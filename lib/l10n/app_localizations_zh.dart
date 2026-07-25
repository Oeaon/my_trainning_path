// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => '电子邮箱';

  @override
  String get password => '密码（至少 6 个字符）';

  @override
  String get forgottenPassword => '忘记密码？';

  @override
  String get recoverPassword => '找回密码';

  @override
  String get recoverPasswordText => '请输入您的注册电子邮箱，我们将向您发送重置密码的链接。';

  @override
  String get resetPasswordSuccess => '重置密码的链接已发送至您的邮箱。';

  @override
  String get resetPasswordError => '处理请求时出错。';

  @override
  String get sendLink => '发送链接';

  @override
  String get createAccount => '创建账号';

  @override
  String get register => '注册';

  @override
  String get registerError => '注册失败';

  @override
  String get login => '登录';

  @override
  String get loginError => '登录失败';

  @override
  String get orContinueWith => '或通过以下方式继续';

  @override
  String get fillAllFields => '请填写所有字段。';

  @override
  String get unexpectedError => '发生意外错误。';

  @override
  String get passwordMinLengthError => '密码长度必须至少为 6 个字符。';

  @override
  String get unexpectedRegisterError => '注册过程中发生意外错误。';

  @override
  String get googleLoginError => '使用 Google 登录失败。';

  @override
  String get enterEmailError => '请输入您的电子邮箱。';

  @override
  String get resetPasswordEmailError => '发送恢复邮件时出错。';

  @override
  String get emailAlreadyInUseError => '该邮箱已被其他用户注册。';

  @override
  String get userNotFoundError => '未找到使用该邮箱注册的账号。';

  @override
  String get wrongPasswordOrCredentialError => '邮箱或密码错误。';

  @override
  String get invalidEmailError => '电子邮箱格式无效。';

  @override
  String get weakPasswordError => '密码强度太弱（至少 6 个字符）。';

  @override
  String get authError => '身份验证错误';
}
