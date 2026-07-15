// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'What2Eat';

  @override
  String get appNamePersian => 'What2Eat';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginWithMobile => 'Login with mobile number';

  @override
  String get loginSubtitle =>
      'Enter your Iranian mobile number to receive a verification code';

  @override
  String get mobileNumberLabel => 'Mobile number';

  @override
  String get mobileNumberHint => '09XXXXXXXXX';

  @override
  String get invalidMobileNumber => 'Enter a valid mobile number (09XXXXXXXXX)';

  @override
  String get sendOtp => 'Send verification code';

  @override
  String get otpTitle => 'Verification code';

  @override
  String otpSubtitle(String mobile) {
    return 'Enter the 6-digit code sent to $mobile';
  }

  @override
  String get verifyOtp => 'Verify and continue';

  @override
  String get resendOtp => 'Resend code';

  @override
  String get otpSentSuccess => 'Verification code sent';

  @override
  String get otpInvalid => 'Enter the 6-digit verification code';

  @override
  String get navRecipes => 'Recipes';

  @override
  String get navGenerate => 'Generate';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get recipesTabTitle => 'Recipes';

  @override
  String get recipesTabDescription => 'Recipe list and search — Phase 9';

  @override
  String get generateTabTitle => 'Generate Recipe';

  @override
  String get generateTabDescription => 'AI recipe generation — Phase 8';

  @override
  String get favoritesTabTitle => 'Favorites';

  @override
  String get favoritesTabDescription => 'Favorite recipes — Phase 10';

  @override
  String get profileTabTitle => 'Profile';

  @override
  String get profileTabDescription => 'Profile and settings — Phase 6';

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get displayNameHint => 'Enter your name';

  @override
  String get displayNameRequired => 'Display name is required';

  @override
  String get noDisplayName => 'No name set';

  @override
  String get saveProfile => 'Save changes';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully';

  @override
  String get logout => 'Log out';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorTitle => 'Error';

  @override
  String routeNotFound(String path) {
    return 'Route not found: $path';
  }
}
