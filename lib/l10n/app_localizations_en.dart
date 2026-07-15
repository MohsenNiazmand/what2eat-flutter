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
  String get loginPlaceholderHint =>
      'OTP login screen will be implemented in Phase 5';

  @override
  String get continueTemporary => 'Continue (temporary)';

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
  String get errorTitle => 'Error';

  @override
  String routeNotFound(String path) {
    return 'Route not found: $path';
  }
}
