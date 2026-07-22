import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_options.dart';
import 'view/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
return MaterialApp(
      title: 'My Trainning Path Login',
      theme: ThemeData(
        // Configuración básica del tema para combinar con el diseño oscuro
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        useMaterial3: true,
        // Puedes definir un tema de texto blanco por defecto aquí si lo prefieres
      ),
      home: LoginScreen(),
    );
  }
}
