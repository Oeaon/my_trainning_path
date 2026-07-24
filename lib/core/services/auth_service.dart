import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui' as ui;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? get currentUser => _auth.currentUser;

  // Registro con Email y Contraseña
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Inicio de sesión con Email y Contraseña
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Inicio de sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

// Restablecer contraseña respetando el idioma del dispositivo
  Future<void> sendPasswordResetEmail(String email) async {
    // 1. Obtiene el código de idioma del teléfono (ej: 'es', 'en', 'fr')
    final String deviceLanguage = ui.PlatformDispatcher.instance.locale.languageCode;

    // 2. Le indica a Firebase Auth que use ese idioma para el correo
    await _auth.setLanguageCode(deviceLanguage);

    // 3. Envía el correo
    await _auth.sendPasswordResetEmail(email: email);
  }
  // Cerrar sesión en ambos servicios
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}