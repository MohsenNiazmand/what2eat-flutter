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

  @override
  String get managePreferences => 'ترجیحات غذایی';

  @override
  String get preferencesTitle => 'ترجیحات';

  @override
  String get preferencesSubtitle =>
      'محدودیت‌های غذایی و سبک‌های آشپزی مورد علاقه خود را انتخاب کنید تا پیشنهاد دستور پخت شخصی‌سازی شود.';

  @override
  String get preferencesEmptyHint =>
      'هنوز ترجیحی ثبت نکرده‌اید. گزینه‌ها را انتخاب و ذخیره کنید.';

  @override
  String get dietaryRestrictionsSection => 'محدودیت‌های غذایی';

  @override
  String get preferredCuisinesSection => 'سبک‌های آشپزی';

  @override
  String get savePreferences => 'ذخیره ترجیحات';

  @override
  String get deletePreferences => 'حذف ترجیحات';

  @override
  String get deletePreferencesTitle => 'حذف ترجیحات';

  @override
  String get deletePreferencesConfirmation =>
      'آیا مطمئن هستید که می‌خواهید ترجیحات خود را حذف کنید؟';

  @override
  String get preferencesSavedSuccess => 'ترجیحات با موفقیت ذخیره شد';

  @override
  String get preferencesDeletedSuccess => 'ترجیحات با موفقیت حذف شد';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get dietaryVegan => 'وگان';

  @override
  String get dietaryVegetarian => 'گیاهخواری';

  @override
  String get dietaryGlutenFree => 'بدون گلوتن';

  @override
  String get dietaryDairyFree => 'بدون لبنیات';

  @override
  String get dietaryHalal => 'حلال';

  @override
  String get dietaryLowCarb => 'کم‌کربوهیدرات';

  @override
  String get dietaryNutFree => 'بدون آجیل';

  @override
  String get cuisinePersian => 'ایرانی';

  @override
  String get cuisineItalian => 'ایتالیایی';

  @override
  String get cuisineMediterranean => 'مدیترانه‌ای';

  @override
  String get cuisineIndian => 'هندی';

  @override
  String get cuisineChinese => 'چینی';

  @override
  String get cuisineMexican => 'مکزیکی';

  @override
  String get cuisineTurkish => 'ترکی';

  @override
  String get cuisineFrench => 'فرانسوی';

  @override
  String get generateSubtitle =>
      'مواد اولیه‌ای که در اختیار دارید را وارد کنید. هوش مصنوعی یک دستور ایرانی پیشنهاد می‌دهد.';

  @override
  String get ingredientsSection => 'مواد اولیه';

  @override
  String get ingredientHint => 'مثلاً گوجه';

  @override
  String ingredientFieldLabel(int index) {
    return 'ماده $index';
  }

  @override
  String get addIngredient => 'افزودن ماده';

  @override
  String get removeItem => 'حذف';

  @override
  String get ingredientsRequired => 'حداقل یک ماده اولیه وارد کنید';

  @override
  String get showOptionalFields => 'محدودیت‌های اختیاری';

  @override
  String get toolsSection => 'ابزار در دسترس';

  @override
  String get toolHint => 'مثلاً تابه';

  @override
  String toolFieldLabel(int index) {
    return 'ابزار $index';
  }

  @override
  String get addTool => 'افزودن ابزار';

  @override
  String get calorieLimitLabel => 'حداکثر کالری';

  @override
  String get calorieLimitHint => 'حداکثر کالری کل غذا';

  @override
  String get servingsLabel => 'تعداد نفر';

  @override
  String get servingsHint => 'تعداد پرس';

  @override
  String get invalidNumber => 'عدد معتبر وارد کنید';

  @override
  String get generateRecipeButton => 'تولید دستور';

  @override
  String get generatingRecipe => 'در حال تولید دستور…';

  @override
  String get aiProviderFailure =>
      'سرویس هوش مصنوعی موقتاً در دسترس نیست. لطفاً دوباره تلاش کنید.';

  @override
  String get recipeDetailTitle => 'دستور پخت';

  @override
  String get descriptionSection => 'توضیحات';

  @override
  String get instructionsSection => 'مراحل پخت';

  @override
  String get noIngredients => 'ماده‌ای ثبت نشده';

  @override
  String get noInstructions => 'مرحله‌ای ثبت نشده';

  @override
  String prepTimeLabel(int minutes) {
    return 'آماده‌سازی: $minutes دقیقه';
  }

  @override
  String cookTimeLabel(int minutes) {
    return 'پخت: $minutes دقیقه';
  }

  @override
  String servingsCountLabel(int count) {
    return '$count نفر';
  }

  @override
  String caloriesLabel(int calories) {
    return '$calories کیلوکالری';
  }

  @override
  String get searchRecipesHint => 'جستجوی دستور پخت…';

  @override
  String get categoryFilterLabel => 'دسته‌بندی';

  @override
  String get categoryAll => 'همه دسته‌ها';

  @override
  String get categoryMainDish => 'غذای اصلی';

  @override
  String get categoryAppetizer => 'پیش‌غذا';

  @override
  String get categoryDessert => 'دسر';

  @override
  String get categorySoup => 'سوپ';

  @override
  String get categorySalad => 'سالاد';

  @override
  String get categoryStew => 'خورشت';

  @override
  String get noRecipesFound => 'دستور پختی یافت نشد';

  @override
  String totalTimeLabel(int minutes) {
    return '$minutes دقیقه در مجموع';
  }

  @override
  String get noFavoritesFound => 'هنوز دستور مورد علاقه‌ای ندارید';

  @override
  String get addToFavorites => 'افزودن به علاقه‌مندی‌ها';

  @override
  String get removeFromFavorites => 'حذف از علاقه‌مندی‌ها';

  @override
  String get networkError =>
      'اتصال اینترنت برقرار نیست. شبکه را بررسی و دوباره تلاش کنید.';

  @override
  String get sessionExpired =>
      'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.';

  @override
  String get genericError => 'خطایی رخ داد. لطفاً دوباره تلاش کنید.';
}
