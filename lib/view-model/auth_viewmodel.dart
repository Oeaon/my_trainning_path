import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // METODO LOGIN
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor, completa todos los campos.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.signInWithEmail(email: email.trim(), password: password);
      _setLoading(false);
      return true; // Login exitoso
    } on FirebaseAuthException catch (e) {
      _errorMessage = _parseAuthException(e);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = 'Ocurrió un error inesperado.';
      _setLoading(false);
      return false;
    }
  }

  // METODO REGISTRO
  Future<bool> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor, completa todos los campos.';
      notifyListeners();
      return false;
    }

    if (password.length < 6) {
      _errorMessage = 'La contraseña debe tener al menos 6 caracteres.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.signUpWithEmail(email: email.trim(), password: password);
      _setLoading(false);
      return true; // Registro exitoso
    } on FirebaseAuthException catch (e) {
      _errorMessage = _parseAuthException(e);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = 'Ocurrió un error inesperado al registrar.';
      _setLoading(false);
      return false;
    }
  }

  // Traducir errores de Firebase a español
  String _parseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Este correo ya está registrado por otro usuario.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'invalid-email':
        return 'El formato del correo electrónico no es válido.';
      case 'weak-password':
        return 'La contraseña es muy débil (mínimo 6 caracteres).';
      default:
        return 'Error de autenticación: ${e.message}';
    }
  }
}