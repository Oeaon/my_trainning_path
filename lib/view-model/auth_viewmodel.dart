import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trainning_path/l10n/app_localizations.dart';
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

  // LOGIN CON EMAIL (Acepta 'loc' como 3er parámetro)
  Future<bool> login(String email, String password, AppLocalizations loc) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = loc.fillAllFields;
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.signInWithEmail(email: email.trim(), password: password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _parseAuthException(e, loc);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = loc.unexpectedError;
      _setLoading(false);
      return false;
    }
  }

  // REGISTRO CON EMAIL (Acepta 'loc' como 3er parámetro)
  Future<bool> register(String email, String password, AppLocalizations loc) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = loc.fillAllFields;
      notifyListeners();
      return false;
    }

    if (password.length < 6) {
      _errorMessage = loc.passwordMinLengthError;
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.signUpWithEmail(email: email.trim(), password: password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _parseAuthException(e, loc);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = loc.unexpectedRegisterError;
      _setLoading(false);
      return false;
    }
  }

  // LOGIN CON GOOGLE (Acepta 'loc' como 1er parámetro)
  Future<bool> loginWithGoogle(AppLocalizations loc) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final userCredential = await _authService.signInWithGoogle();
      _setLoading(false);
      return userCredential != null;
    } catch (e) {
      print('🔴 DETALLE DEL ERROR DE GOOGLE: $e');
      _errorMessage = loc.googleLoginError;
      _setLoading(false);
      return false;
    }
  }

  // RESTABLECER CONTRASEÑA (Acepta 'loc' como 2º parámetro)
  Future<bool> resetPassword(String email, AppLocalizations loc) async {
    if (email.isEmpty) {
      _errorMessage = loc.enterEmailError;
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.sendPasswordResetEmail(email.trim());
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _parseAuthException(e, loc);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = loc.resetPasswordEmailError;
      _setLoading(false);
      return false;
    }
  }

  String _parseAuthException(FirebaseAuthException e, AppLocalizations loc) {
    switch (e.code) {
      case 'email-already-in-use':
        return loc.emailAlreadyInUseError;
      case 'user-not-found':
        return loc.userNotFoundError;
      case 'wrong-password':
      case 'invalid-credential':
        return loc.wrongPasswordOrCredentialError;
      case 'invalid-email':
        return loc.invalidEmailError;
      case 'weak-password':
        return loc.weakPasswordError;
      default:
        return '${loc.authError}: ${e.message}';
    }
  }
}