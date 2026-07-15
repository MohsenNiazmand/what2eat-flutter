// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'What2Eat';

  @override
  String get appNamePersian => 'چی بخورم';

  @override
  String get loginTitle => 'ورود';

  @override
  String get loginWithMobile => 'ورود با شماره موبایل';

  @override
  String get loginPlaceholderHint =>
      'صفحه ورود OTP در Phase 5 پیاده‌سازی می‌شود';

  @override
  String get continueTemporary => 'ادامه (موقت)';

  @override
  String get navRecipes => 'دستورها';

  @override
  String get navGenerate => 'تولید';

  @override
  String get navFavorites => 'علاقه‌مندی';

  @override
  String get navProfile => 'پروفایل';

  @override
  String get recipesTabTitle => 'دستورهای پخت';

  @override
  String get recipesTabDescription => 'لیست و جستجوی دستور پخت — Phase 9';

  @override
  String get generateTabTitle => 'تولید دستور';

  @override
  String get generateTabDescription => 'تولید دستور با هوش مصنوعی — Phase 8';

  @override
  String get favoritesTabTitle => 'علاقه‌مندی‌ها';

  @override
  String get favoritesTabDescription => 'دستورهای مورد علاقه — Phase 10';

  @override
  String get profileTabTitle => 'پروفایل';

  @override
  String get profileTabDescription => 'پروفایل و تنظیمات — Phase 6';

  @override
  String get errorTitle => 'خطا';

  @override
  String routeNotFound(String path) {
    return 'مسیر یافت نشد: $path';
  }
}
