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
  String get loginSubtitle =>
      'شماره موبایل خود را وارد کنید تا کد تأیید برایتان ارسال شود';

  @override
  String get mobileNumberLabel => 'شماره موبایل';

  @override
  String get mobileNumberHint => '09XXXXXXXXX';

  @override
  String get invalidMobileNumber =>
      'شماره موبایل معتبر وارد کنید (09XXXXXXXXX)';

  @override
  String get sendOtp => 'ارسال کد تأیید';

  @override
  String get otpTitle => 'کد تأیید';

  @override
  String otpSubtitle(String mobile) {
    return 'کد ۶ رقمی ارسال‌شده به $mobile را وارد کنید';
  }

  @override
  String get verifyOtp => 'تأیید و ادامه';

  @override
  String get resendOtp => 'ارسال مجدد کد';

  @override
  String get otpSentSuccess => 'کد تأیید ارسال شد';

  @override
  String get otpInvalid => 'کد تأیید ۶ رقمی را وارد کنید';

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
  String get displayNameLabel => 'نام نمایشی';

  @override
  String get displayNameHint => 'نام خود را وارد کنید';

  @override
  String get displayNameRequired => 'نام نمایشی الزامی است';

  @override
  String get noDisplayName => 'نام ثبت نشده';

  @override
  String get saveProfile => 'ذخیره تغییرات';

  @override
  String get profileUpdatedSuccess => 'پروفایل با موفقیت به‌روزرسانی شد';

  @override
  String get logout => 'خروج از حساب';

  @override
  String get logoutTitle => 'خروج';

  @override
  String get logoutConfirmation => 'آیا مطمئن هستید که می‌خواهید خارج شوید؟';

  @override
  String get confirm => 'تأیید';

  @override
  String get cancel => 'انصراف';

  @override
  String get errorTitle => 'خطا';

  @override
  String routeNotFound(String path) {
    return 'مسیر یافت نشد: $path';
  }
}
