// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña (Mínimo 6 caracteres)';

  @override
  String get forgottenPassword => '¿Olvidaste tu contraseña?';

  @override
  String get recoverPassword => 'Recuperar contraseña';

  @override
  String get recoverPasswordText => 'Introduce tu correo electrónico registrado y te enviaremos un enlace para restablecer tu contraseña.';

  @override
  String get resetPasswordSuccess => 'Se ha enviado un enlace a tu correo para restablecer la contraseña.';

  @override
  String get resetPasswordError => 'Error al procesar la solicitud.';

  @override
  String get sendLink => 'Enviar enlace';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get register => 'Registrarse';

  @override
  String get registerError => 'Error al registrar';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get loginError => 'Error al iniciar sesión';

  @override
  String get orContinueWith => 'O continuar con';

  @override
  String get fillAllFields => 'Por favor, completa todos los campos.';

  @override
  String get unexpectedError => 'Ocurrió un error inesperado.';

  @override
  String get passwordMinLengthError => 'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get unexpectedRegisterError => 'Ocurrió un error inesperado al registrar.';

  @override
  String get googleLoginError => 'Error al iniciar sesión con Google.';

  @override
  String get enterEmailError => 'Por favor, introduce tu correo electrónico.';

  @override
  String get resetPasswordEmailError => 'Ocurrió un error al enviar el correo de recuperación.';

  @override
  String get emailAlreadyInUseError => 'Este correo ya está registrado por otro usuario.';

  @override
  String get userNotFoundError => 'No existe ninguna cuenta registrada con este correo.';

  @override
  String get wrongPasswordOrCredentialError => 'Correo o contraseña incorrectos.';

  @override
  String get invalidEmailError => 'El formato del correo electrónico no es válido.';

  @override
  String get weakPasswordError => 'La contraseña es muy débil (mínimo 6 caracteres).';

  @override
  String get authError => 'Error de autenticación';
}
