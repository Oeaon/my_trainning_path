import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          '¡Bienvenido a My Training Path! 🏋️‍♂️',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}