import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'core/config/firebase_options.dart';
import 'view/login_screen.dart';
import 'view-model/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Training Path',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        useMaterial3: true,
      ),

      // 1. Cargadores automáticos de traducciones (Material, Widgets y Cupertino)
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // 2. Lee automáticamente TODOS los idiomas que creaste en tu carpeta l10n
      supportedLocales: AppLocalizations.supportedLocales,

      // 3. Comprueba el idioma del dispositivo cada vez que se abre la app
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == deviceLocale.languageCode) {
              return supportedLocale; // Usa el idioma del teléfono si lo tenemos traducido
            }
          }
        }
        // Idioma de respaldo (Fallback) si el teléfono está en un idioma no soportado
        return const Locale('es');
      },

      home: const LoginScreen(),
    );
  }
}