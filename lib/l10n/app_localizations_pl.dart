// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'Adres e-mail';

  @override
  String get password => 'Hasło (minimum 6 znaków)';

  @override
  String get forgottenPassword => 'Nie pamiętasz hasła?';

  @override
  String get recoverPassword => 'Odzyskaj hasło';

  @override
  String get recoverPasswordText => 'Wprowadź zarejestrowany adres e-mail, a wyślemy Ci link do zresetowania hasła.';

  @override
  String get resetPasswordSuccess => 'Link do zresetowania hasła został wysłany na Twój adres e-mail.';

  @override
  String get resetPasswordError => 'Błąd podczas przetwarzania żądania.';

  @override
  String get sendLink => 'Wyślij link';

  @override
  String get createAccount => 'Utwórz konto';

  @override
  String get register => 'Zarejestruj się';

  @override
  String get registerError => 'Błąd rejestracji';

  @override
  String get login => 'Zaloguj się';

  @override
  String get loginError => 'Błąd logowania';

  @override
  String get orContinueWith => 'Lub kontynuuj przez';

  @override
  String get fillAllFields => 'Proszę wypełnić wszystkie pola.';

  @override
  String get unexpectedError => 'Wystąpił nieoczekiwany błąd.';

  @override
  String get passwordMinLengthError => 'Hasło musi mieć co najmniej 6 znaków.';

  @override
  String get unexpectedRegisterError => 'Wystąpił nieoczekiwany błąd podczas rejestracji.';

  @override
  String get googleLoginError => 'Błąd logowania przez Google.';

  @override
  String get enterEmailError => 'Wprowadź swój adres e-mail.';

  @override
  String get resetPasswordEmailError => 'Wystąpił błąd podczas wysyłania wiadomości do odzyskiwania hasła.';

  @override
  String get emailAlreadyInUseError => 'Ten e-mail jest już zarejestrowany przez innego użytkownika.';

  @override
  String get userNotFoundError => 'Brak konta zarejestrowanego na ten adres e-mail.';

  @override
  String get wrongPasswordOrCredentialError => 'Nieprawidłowy e-mail lub hasło.';

  @override
  String get invalidEmailError => 'Nieprawidłowy format adresu e-mail.';

  @override
  String get weakPasswordError => 'Hasło jest zbyt słabe (minimum 6 znaków).';

  @override
  String get authError => 'Błąd uwierzytelniania';
}
