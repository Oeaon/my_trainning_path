// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'My Training Path';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड (न्यूनतम 6 अक्षर)';

  @override
  String get forgottenPassword => 'क्या आप अपना पासवर्ड भूल गए?';

  @override
  String get recoverPassword => 'पासवर्ड पुनर्प्राप्त करें';

  @override
  String get recoverPasswordText => 'अपना पंजीकृत ईमेल दर्ज करें और हम आपको पासवर्ड रीसेट करने के लिए एक लिंक भेजेंगे।';

  @override
  String get resetPasswordSuccess => 'पासवर्ड रीसेट करने का लिंक आपके ईमेल पर भेज दिया गया है।';

  @override
  String get resetPasswordError => 'अनुरोध को संसाधित करने में त्रुटि।';

  @override
  String get sendLink => 'लिंक भेजें';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get register => 'रजिस्टर करें';

  @override
  String get registerError => 'रजिस्टर करने में त्रुटि';

  @override
  String get login => 'लॉग इन करें';

  @override
  String get loginError => 'लॉग इन करने में त्रुटि';

  @override
  String get orContinueWith => 'या इसके साथ जारी रखें';

  @override
  String get fillAllFields => 'कृपया सभी फ़ील्ड भरें।';

  @override
  String get unexpectedError => 'एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get passwordMinLengthError => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।';

  @override
  String get unexpectedRegisterError => 'रजिस्टर करते समय एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get googleLoginError => 'Google के साथ लॉग इन करने में त्रुटि।';

  @override
  String get enterEmailError => 'कृपया अपना ईमेल दर्ज करें।';

  @override
  String get resetPasswordEmailError => 'रिकवरी ईमेल भेजने में एक त्रुटि हुई।';

  @override
  String get emailAlreadyInUseError => 'यह ईमेल पहले से ही किसी अन्य उपयोगकर्ता द्वारा पंजीकृत है।';

  @override
  String get userNotFoundError => 'इस ईमेल के साथ कोई पंजीकृत खाता नहीं है।';

  @override
  String get wrongPasswordOrCredentialError => 'गलत ईमेल या पासवर्ड।';

  @override
  String get invalidEmailError => 'ईमेल प्रारूप अमान्य है।';

  @override
  String get weakPasswordError => 'पासवर्ड बहुत कमजोर है (न्यूनतम 6 अक्षर)।';

  @override
  String get authError => 'प्रमाणीकरण त्रुटि';
}
