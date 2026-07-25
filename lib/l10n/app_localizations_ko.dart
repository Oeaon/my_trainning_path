// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호 (최소 6자)';

  @override
  String get forgottenPassword => '비밀번호를 잊으셨나요?';

  @override
  String get recoverPassword => '비밀번호 찾기';

  @override
  String get recoverPasswordText => '등록된 이메일 주소를 입력하시면 비밀번호 재설정 링크를 보내드립니다.';

  @override
  String get resetPasswordSuccess => '비밀번호 재설정 링크가 이메일로 전송되었습니다.';

  @override
  String get resetPasswordError => '요청을 처리하는 중 오류가 발생했습니다.';

  @override
  String get sendLink => '링크 전송';

  @override
  String get createAccount => '계정 생성';

  @override
  String get register => '회원가입';

  @override
  String get registerError => '회원가입 오류';

  @override
  String get login => '로그인';

  @override
  String get loginError => '로그인 오류';

  @override
  String get orContinueWith => '또는 다음으로 계속';

  @override
  String get fillAllFields => '모든 항목을 입력해 주세요.';

  @override
  String get unexpectedError => '예기치 않은 오류가 발생했습니다.';

  @override
  String get passwordMinLengthError => '비밀번호는 최소 6자 이상이어야 합니다.';

  @override
  String get unexpectedRegisterError => '회원가입 중 예기치 않은 오류가 발생했습니다.';

  @override
  String get googleLoginError => 'Google 로그인 오류.';

  @override
  String get enterEmailError => '이메일 주소를 입력해 주세요.';

  @override
  String get resetPasswordEmailError => '비밀번호 재설정 이메일을 보내는 중 오류가 발생했습니다.';

  @override
  String get emailAlreadyInUseError => '이미 다른 사용자가 등록한 이메일입니다.';

  @override
  String get userNotFoundError => '해당 이메일로 등록된 계정이 없습니다.';

  @override
  String get wrongPasswordOrCredentialError => '잘못된 이메일 또는 비밀번호입니다.';

  @override
  String get invalidEmailError => '올바르지 않은 이메일 형식입니다.';

  @override
  String get weakPasswordError => '비밀번호가 너무 취약합니다 (최소 6자).';

  @override
  String get authError => '인증 오류';
}
