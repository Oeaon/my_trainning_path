import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  static const Color _customBackgroundColor = Color(0xFF0F0F0F);

  static const Color _customYellow = Color(0xFFEBC134);


  static const TextStyle _customTitleStyle = TextStyle(
    color: _customYellow,
    fontSize: 36,
    //fontWeight: FontWeight.bold,
    fontFamily: 'GrindAndDeath', 
  );

  static const TextStyle _customFormLabelStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'NotoSans', 
  );

  static const TextStyle _customButtonStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'NotoSans', 
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _customBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                
                const Text(
                  'MY TRAINNING PATH',
                  style: _customTitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 100), // Espaciado grande debajo del título

                // --- FORMULARIO ---
                _buildTextField('Email', Icons.email_outlined),
                const SizedBox(height: 30), // Espaciado entre campos
                _buildTextField('Password', Icons.lock_outline, isObscure: true),
                const SizedBox(height: 120), // Espaciado muy grande antes de los botones inferiores

                // --- BOTONES INFERIORES ---
                // "Register" - Centralizado y blanco
                InkWell(
                  onTap: () {
                    // Acción para ir a la pantalla de registro
                  },
                  child: const Text(
                    'Register',
                    style: _customButtonStyle,
                  ),
                ),
                const SizedBox(height: 30), // Espaciado entre botones

                // "login" - Centralizado y blanco (coincidiendo con la minúscula de la imagen)
                InkWell(
                  onTap: () {
                    // Acción para iniciar sesión
                  },
                  child: const Text(
                    'login',
                    style: _customButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget helper para crear los campos de texto con iconos ---
  Widget _buildTextField(String label, IconData icon, {bool isObscure = false}) {
    return TextField(
      obscureText: isObscure,
      style: _customFormLabelStyle, // Para el texto que el usuario escribe
      decoration: InputDecoration(
        labelText: label,
        labelStyle: _customFormLabelStyle, // Para la etiqueta flotante (blanca)
        prefixIcon: Icon(icon, color: Colors.white70), // Un icono blanco y sutil
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _customYellow, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
      ),
    );
  }
}