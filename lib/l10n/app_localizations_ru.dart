// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль (минимум 6 символов)';

  @override
  String get forgottenPassword => 'Забыли пароль?';

  @override
  String get recoverPassword => 'Восстановить пароль';

  @override
  String get recoverPasswordText => 'Введите зарегистрированный адрес электронной почты, и мы отправим вам ссылку для сброса пароля.';

  @override
  String get resetPasswordSuccess => 'Ссылка для сброса пароля отправлена на вашу электронную почту.';

  @override
  String get resetPasswordError => 'Ошибка при обработке запроса.';

  @override
  String get sendLink => 'Отправить ссылку';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get registerError => 'Ошибка при регистрации';

  @override
  String get login => 'Войти';

  @override
  String get loginError => 'Ошибка при входе';

  @override
  String get orContinueWith => 'Или продолжить через';

  @override
  String get fillAllFields => 'Пожалуйста, заполните все поля.';

  @override
  String get unexpectedError => 'Произошла непредвиденная ошибка.';

  @override
  String get passwordMinLengthError => 'Пароль должен содержать не менее 6 символов.';

  @override
  String get unexpectedRegisterError => 'Произошла непредвиденная ошибка при регистрации.';

  @override
  String get googleLoginError => 'Ошибка при входе через Google.';

  @override
  String get enterEmailError => 'Пожалуйста, введите ваш адрес электронной почты.';

  @override
  String get resetPasswordEmailError => 'Произошла ошибка при отправке письма для восстановления.';

  @override
  String get emailAlreadyInUseError => 'Этот адрес электронной почты уже зарегистрирован другим пользователем.';

  @override
  String get userNotFoundError => 'Аккаунт с таким адресом электронной почты не найден.';

  @override
  String get wrongPasswordOrCredentialError => 'Неверный адрес электронной почты или пароль.';

  @override
  String get invalidEmailError => 'Неверный формат электронной почты.';

  @override
  String get weakPasswordError => 'Слишком простой пароль (минимум 6 символов).';

  @override
  String get authError => 'Ошибка аутентификации';
}
