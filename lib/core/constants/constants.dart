import 'package:what_2_eat/core/constants/app_config.dart';

class Constants {
  Constants._();

  static String get baseUrl => AppConfig.apiBaseUrl;

  /// Iranian mobile number pattern: 09XXXXXXXXX
  static final RegExp mobileNumberPattern = RegExp(r'^09\d{9}$');

  static const int otpLength = 6;
}
