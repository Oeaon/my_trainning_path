import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view-model/auth_viewmodel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  static const Color _customBackgroundColor = Color(0xFF0F0F0F);
  static const Color _customYellow = Color(0xFFEBC134);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onResetPressed() async {
    final authViewModel = context.read<AuthViewModel>();
    final success = await authViewModel.resetPassword(_emailController.text);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Se ha enviado un enlace a tu correo para restablecer la contraseña.'),
        ),
      );
      Navigator.pop(context); // Volver al Login tras enviar el correo
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(authViewModel.errorMessage ?? 'Error al procesar la solicitud.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: _customBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'RECUPERAR CONTRASEÑA',
                      style: TextStyle(
                        color: _customYellow,
                        fontSize: 32,
                       // fontWeight: FontWeight.bold,
                        fontFamily: 'GrindAndDeath',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Introduce tu correo electrónico registrado y te enviaremos un enlace para restablecer tu contraseña.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _customYellow, width: 2.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  authViewModel.isLoading
                      ? const CircularProgressIndicator(color: _customYellow)
                      : InkWell(
                          onTap: _onResetPressed,
                          child: const Text(
                            'Enviar Enlace',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}