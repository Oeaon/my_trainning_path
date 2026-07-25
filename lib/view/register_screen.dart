import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view-model/auth_viewmodel.dart';
import 'package:my_trainning_path/l10n/app_localizations.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

void _onRegisterPressed() async {
    final authViewModel = context.read<AuthViewModel>();
    final loc = AppLocalizations.of(context)!;

    final success = await authViewModel.register(
      _emailController.text,
      _passwordController.text,
      loc,
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
          content: Text(authViewModel.errorMessage ?? loc.registerError),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
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
                children: [
                  Text(
                    loc.createAccount.toUpperCase(),
                    style: const TextStyle(
                      color: _customYellow,
                      fontSize: 36,
                      fontFamily: 'GrindAndDeath',
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: loc.email,
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: _customYellow),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: loc.password,
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: _customYellow),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  authViewModel.isLoading
                      ? const CircularProgressIndicator(color: _customYellow)
                      : InkWell(
                          onTap: _onRegisterPressed,
                          child: Text(
                            loc.register, 
                            style: const TextStyle(color: Colors.white, fontSize: 22),
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