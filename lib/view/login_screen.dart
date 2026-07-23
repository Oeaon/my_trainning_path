import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view-model/auth_viewmodel.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color _customBackgroundColor = Color(0xFF0F0F0F);
  static const Color _customYellow = Color(0xFFEBC134);

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      setState(() {
        _emailController.text = savedEmail;
      });
    }
  }

  Future<void> _saveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      await prefs.setString('saved_email', email);
    }
  }

  void _onLoginPressed() async {
    await _saveEmail();

    if (!mounted) return;

    final authViewModel = context.read<AuthViewModel>();
    final success = await authViewModel.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(authViewModel.errorMessage ?? 'Error al iniciar sesión'),
        ),
      );
    }
  }

  void _onGoogleLoginPressed() async {
    final authViewModel = context.read<AuthViewModel>();
    final success = await authViewModel.loginWithGoogle();

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (authViewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(authViewModel.errorMessage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _customBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'MY TRAINNING PATH',
                        style: TextStyle(
                          color: _customYellow,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GrindAndDeath',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.06),

                    _buildTextField('Email', Icons.email_outlined, _emailController),
                    SizedBox(height: screenHeight * 0.025),
                    _buildTextField('Password', Icons.lock_outline, _passwordController, isObscure: true),

                    SizedBox(height: screenHeight * 0.06),

                    // BOTÓN REGISTER
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // BOTÓN LOGIN
                    authViewModel.isLoading
                        ? const CircularProgressIndicator(color: _customYellow)
                        : InkWell(
                            onTap: _onLoginPressed,
                            child: const Text('login', style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),

                    SizedBox(height: screenHeight * 0.04),

                    // SEPARADOR Y OPCIÓN GOOGLE
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('o continúa con', style: TextStyle(color: Colors.white54, fontSize: 14)),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // BOTÓN CONTINUAR CON GOOGLE
                    OutlinedButton.icon(
                      onPressed: authViewModel.isLoading ? null : _onGoogleLoginPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white38),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const Icon(Icons.g_mobiledata, color: _customYellow, size: 32),
                      label: const Text(
                        'Google',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: _customYellow, width: 2.0)),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      ),
    );
  }
}