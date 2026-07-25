import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_trainning_path/l10n/app_localizations.dart';
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
    // 1. Obtenemos la localización
    final loc = AppLocalizations.of(context)!;

    // 2. Pasamos 'loc' como segundo argumento a resetPassword()
    final success = await authViewModel.resetPassword(
      _emailController.text,
      loc,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(loc.resetPasswordSuccess),
        ),
      );
      Navigator.pop(context); // Volver al Login tras enviar el correo
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(authViewModel.errorMessage ?? loc.resetPasswordError),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                  // TÍTULO TRADUCIDO
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      loc.recoverPassword.toUpperCase(),
                      style: const TextStyle(
                        color: _customYellow,
                        fontSize: 32,
                        fontFamily: 'GrindAndDeath',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // TEXTO EXPLICATIVO TRADUCIDO
                  Text(
                    loc.recoverPasswordText,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // CAMPO EMAIL TRADUCIDO
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: loc.email,
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54, width: 1.5),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: _customYellow, width: 2.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // BOTÓN TRADUCIDO
                  authViewModel.isLoading
                      ? const CircularProgressIndicator(color: _customYellow)
                      : InkWell(
                          onTap: _onResetPressed,
                          child: Text(
                            loc.sendLink,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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