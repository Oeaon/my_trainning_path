// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe (Minimum 6 caractères)';

  @override
  String get forgottenPassword => 'Mot de passe oublié ?';

  @override
  String get recoverPassword => 'Récupérer le mot de passe';

  @override
  String get recoverPasswordText => 'Entrez votre adresse e-mail enregistrée et nous vous enverrons un lien pour réinitialiser votre mot de passe.';

  @override
  String get resetPasswordSuccess => 'Un lien de réinitialisation du mot de passe a été envoyé à votre adresse e-mail.';

  @override
  String get resetPasswordError => 'Erreur lors du traitement de la demande.';

  @override
  String get sendLink => 'Envoyer le lien';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get register => 'S\'inscrire';

  @override
  String get registerError => 'Erreur lors de l\'inscription';

  @override
  String get login => 'Se connecter';

  @override
  String get loginError => 'Erreur de connexion';

  @override
  String get orContinueWith => 'Ou continuer avec';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs.';

  @override
  String get unexpectedError => 'Une erreur inattendue est survenue.';

  @override
  String get passwordMinLengthError => 'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get unexpectedRegisterError => 'Une erreur inattendue est survenue lors de l\'inscription.';

  @override
  String get googleLoginError => 'Erreur lors de la connexion avec Google.';

  @override
  String get enterEmailError => 'Veuillez entrer votre adresse e-mail.';

  @override
  String get resetPasswordEmailError => 'Une erreur est survenue lors de l\'envoi de l\'e-mail de récupération.';

  @override
  String get emailAlreadyInUseError => 'Cet e-mail est déjà utilisé par un autre utilisateur.';

  @override
  String get userNotFoundError => 'Aucun compte n\'est enregistré avec cet e-mail.';

  @override
  String get wrongPasswordOrCredentialError => 'E-mail ou mot de passe incorrect.';

  @override
  String get invalidEmailError => 'Le format de l\'e-mail n\'est pas valide.';

  @override
  String get weakPasswordError => 'Le mot de passe est trop faible (minimum 6 caractères).';

  @override
  String get authError => 'Erreur d\'authentification';
}
