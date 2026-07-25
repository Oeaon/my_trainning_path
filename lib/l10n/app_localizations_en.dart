// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password (Minimum 6 characters)';

  @override
  String get forgottenPassword => 'Forgot your password?';

  @override
  String get recoverPassword => 'Recover password';

  @override
  String get recoverPasswordText => 'Enter your registered email address and we will send you a link to reset your password.';

  @override
  String get resetPasswordSuccess => 'A link has been sent to your email to reset your password.';

  @override
  String get resetPasswordError => 'Error processing request.';

  @override
  String get sendLink => 'Send link';

  @override
  String get createAccount => 'Create account';

  @override
  String get register => 'Register';

  @override
  String get registerError => 'Error registering';

  @override
  String get login => 'Log in';

  @override
  String get loginError => 'Error logging in';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get fillAllFields => 'Please fill in all fields.';

  @override
  String get unexpectedError => 'An unexpected error occurred.';

  @override
  String get passwordMinLengthError => 'Password must be at least 6 characters long.';

  @override
  String get unexpectedRegisterError => 'An unexpected error occurred while registering.';

  @override
  String get googleLoginError => 'Error signing in with Google.';

  @override
  String get enterEmailError => 'Please enter your email address.';

  @override
  String get resetPasswordEmailError => 'An error occurred while sending the recovery email.';

  @override
  String get emailAlreadyInUseError => 'This email is already registered by another user.';

  @override
  String get userNotFoundError => 'There is no account registered with this email.';

  @override
  String get wrongPasswordOrCredentialError => 'Incorrect email or password.';

  @override
  String get invalidEmailError => 'The email address format is invalid.';

  @override
  String get weakPasswordError => 'The password is too weak (minimum 6 characters).';

  @override
  String get authError => 'Authentication error';
}
