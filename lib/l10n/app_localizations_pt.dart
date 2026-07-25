// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Palavra-passe (Mínimo 6 caracteres)';

  @override
  String get forgottenPassword => 'Esqueceu-se da palavra-passe?';

  @override
  String get recoverPassword => 'Recuperar palavra-passe';

  @override
  String get recoverPasswordText => 'Introduza o seu e-mail registado e enviaremos um link para redefinir a sua palavra-passe.';

  @override
  String get resetPasswordSuccess => 'Foi enviado um link para o seu e-mail para redefinir a palavra-passe.';

  @override
  String get resetPasswordError => 'Erro ao processar o pedido.';

  @override
  String get sendLink => 'Enviar link';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get register => 'Registar';

  @override
  String get registerError => 'Erro ao registar';

  @override
  String get login => 'Iniciar sessão';

  @override
  String get loginError => 'Erro ao iniciar sessão';

  @override
  String get orContinueWith => 'Ou continuar com';

  @override
  String get fillAllFields => 'Por favor, preencha todos os campos.';

  @override
  String get unexpectedError => 'Ocorreu um erro inesperado.';

  @override
  String get passwordMinLengthError => 'A palavra-passe deve ter pelo menos 6 caracteres.';

  @override
  String get unexpectedRegisterError => 'Ocorreu um erro inesperado ao registar.';

  @override
  String get googleLoginError => 'Erro ao iniciar sessão com o Google.';

  @override
  String get enterEmailError => 'Por favor, introduza o seu e-mail.';

  @override
  String get resetPasswordEmailError => 'Ocorreu um erro ao enviar o e-mail de recuperação.';

  @override
  String get emailAlreadyInUseError => 'Este e-mail já está registado por outro utilizador.';

  @override
  String get userNotFoundError => 'Não existe nenhuma conta registada com este e-mail.';

  @override
  String get wrongPasswordOrCredentialError => 'E-mail ou palavra-passe incorretos.';

  @override
  String get invalidEmailError => 'O formato do e-mail não é válido.';

  @override
  String get weakPasswordError => 'A palavra-passe é muito fraca (mínimo 6 caracteres).';

  @override
  String get authError => 'Erro de autenticação';
}
