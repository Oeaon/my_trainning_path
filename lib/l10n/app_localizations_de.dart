// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort (Mindestens 6 Zeichen)';

  @override
  String get forgottenPassword => 'Passwort vergessen?';

  @override
  String get recoverPassword => 'Passwort wiederherstellen';

  @override
  String get recoverPasswordText => 'Geben Sie Ihre registrierte E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen Ihres Passworts.';

  @override
  String get resetPasswordSuccess => 'Ein Link zum Zurücksetzen des Passworts wurde an Ihre E-Mail gesendet.';

  @override
  String get resetPasswordError => 'Fehler beim Verarbeiten der Anfrage.';

  @override
  String get sendLink => 'Link senden';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get register => 'Registrieren';

  @override
  String get registerError => 'Fehler bei der Registrierung';

  @override
  String get login => 'Anmelden';

  @override
  String get loginError => 'Fehler beim Anmelden';

  @override
  String get orContinueWith => 'Oder fortfahren mit';

  @override
  String get fillAllFields => 'Bitte füllen Sie alle Felder aus.';

  @override
  String get unexpectedError => 'Ein unerwarteter Fehler ist aufgetreten.';

  @override
  String get passwordMinLengthError => 'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get unexpectedRegisterError => 'Bei der Registrierung ist ein unerwarteter Fehler aufgetreten.';

  @override
  String get googleLoginError => 'Fehler bei der Anmeldung mit Google.';

  @override
  String get enterEmailError => 'Bitte geben Sie Ihre E-Mail-Adresse ein.';

  @override
  String get resetPasswordEmailError => 'Beim Senden der Wiederherstellungs-E-Mail ist ein Fehler aufgetreten.';

  @override
  String get emailAlreadyInUseError => 'Diese E-Mail-Adresse wird bereits von einem anderen Benutzer verwendet.';

  @override
  String get userNotFoundError => 'Es existiert kein Konto mit dieser E-Mail-Adresse.';

  @override
  String get wrongPasswordOrCredentialError => 'Falsche E-Mail-Adresse oder falsches Passwort.';

  @override
  String get invalidEmailError => 'Das Format der E-Mail-Adresse ist ungültig.';

  @override
  String get weakPasswordError => 'Das Passwort ist zu schwach (mindestens 6 Zeichen).';

  @override
  String get authError => 'Authentifizierungsfehler';
}
