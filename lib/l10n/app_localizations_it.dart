// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password (Minimo 6 caratteri)';

  @override
  String get forgottenPassword => 'Password dimenticata?';

  @override
  String get recoverPassword => 'Recupera password';

  @override
  String get recoverPasswordText => 'Inserisci il tuo indirizzo e-mail registrato e ti invieremo un link per reimpostare la tua password.';

  @override
  String get resetPasswordSuccess => 'Un link per reimpostare la password è stato inviato alla tua e-mail.';

  @override
  String get resetPasswordError => 'Errore durante l\'elaborazione della richiesta.';

  @override
  String get sendLink => 'Invia link';

  @override
  String get createAccount => 'Crea account';

  @override
  String get register => 'Registrati';

  @override
  String get registerError => 'Errore durante la registrazione';

  @override
  String get login => 'Accedi';

  @override
  String get loginError => 'Errore durante l\'accesso';

  @override
  String get orContinueWith => 'Oppure continua con';

  @override
  String get fillAllFields => 'Si prega di compilare tutti i campi.';

  @override
  String get unexpectedError => 'Si è verificato un errore imprevisto.';

  @override
  String get passwordMinLengthError => 'La password deve contenere almeno 6 caratteri.';

  @override
  String get unexpectedRegisterError => 'Si è verificato un errore imprevisto durante la registrazione.';

  @override
  String get googleLoginError => 'Errore durante l\'accesso con Google.';

  @override
  String get enterEmailError => 'Inserisci il tuo indirizzo e-mail.';

  @override
  String get resetPasswordEmailError => 'Si è verificato un errore durante l\'invio dell\'e-mail di recupero.';

  @override
  String get emailAlreadyInUseError => 'Questa e-mail è già registrata da un altro utente.';

  @override
  String get userNotFoundError => 'Non esiste alcun account registrato con questa e-mail.';

  @override
  String get wrongPasswordOrCredentialError => 'E-mail o password non corrette.';

  @override
  String get invalidEmailError => 'Il formato dell\'e-mail non è valido.';

  @override
  String get weakPasswordError => 'La password è troppo debole (minimo 6 caratteri).';

  @override
  String get authError => 'Errore di autenticazione';
}
