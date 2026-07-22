import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view-model/auth_viewmodel.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color _customYellow = Color(0xFFEBC134);

  void _onRegisterPressed() async {
    final authViewModel = context.read<AuthViewModel>();
    final success = await authViewModel.register(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      // Si el registro es correcto, navega a HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Muestra error devuelto por Firebase (ej: usuario ya registrado)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(authViewModel.errorMessage ?? 'Error al registrar'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  const Text(
                    'CREAR CUENTA',
                    style: TextStyle(
                      color: _customYellow,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GrindAndDeath',
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: _customYellow)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Password (mínimo 6 caracteres)',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: _customYellow)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  authViewModel.isLoading
                      ? const CircularProgressIndicator(color: _customYellow)
                      : InkWell(
                          onTap: _onRegisterPressed,
                          child: const Text('Registrarse', style: TextStyle(color: Colors.white, fontSize: 22)),
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