// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'メールアドレス';

  @override
  String get password => 'パスワード（6文字以上）';

  @override
  String get forgottenPassword => 'パスワードをお忘れですか？';

  @override
  String get recoverPassword => 'パスワードの再設定';

  @override
  String get recoverPasswordText => '登録したメールアドレスを入力してください。パスワード再設定用のリンクをお送りします。';

  @override
  String get resetPasswordSuccess => 'パスワード再設定用のリンクをメールに送信しました。';

  @override
  String get resetPasswordError => 'リクエストの処理中にエラーが発生しました。';

  @override
  String get sendLink => 'リンクを送信';

  @override
  String get createAccount => 'アカウント作成';

  @override
  String get register => '新規登録';

  @override
  String get registerError => '登録エラー';

  @override
  String get login => 'ログイン';

  @override
  String get loginError => 'ログインエラー';

  @override
  String get orContinueWith => 'または以下で継続';

  @override
  String get fillAllFields => 'すべての項目を入力してください。';

  @override
  String get unexpectedError => '予期しないエラーが発生しました。';

  @override
  String get passwordMinLengthError => 'パスワードは6文字以上で入力してください。';

  @override
  String get unexpectedRegisterError => '登録中に予期しないエラーが発生しました。';

  @override
  String get googleLoginError => 'Google ログインエラー。';

  @override
  String get enterEmailError => 'メールアドレスを入力してください。';

  @override
  String get resetPasswordEmailError => '再設定メールの送信中にエラーが発生しました。';

  @override
  String get emailAlreadyInUseError => 'このメールアドレスは既に登録されています。';

  @override
  String get userNotFoundError => 'このメールアドレスで登録されたアカウントは見つかりません。';

  @override
  String get wrongPasswordOrCredentialError => 'メールアドレスまたはパスワードが正しくありません。';

  @override
  String get invalidEmailError => '無効なメールアドレス形式です。';

  @override
  String get weakPasswordError => 'パスワードが脆弱すぎます（6文字以上必要です）。';

  @override
  String get authError => '認証エラー';
}
