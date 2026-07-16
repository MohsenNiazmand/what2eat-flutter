import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'What2Eat'**
  String get appName;

  /// No description provided for @appNamePersian.
  ///
  /// In en, this message translates to:
  /// **'What2Eat'**
  String get appNamePersian;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginWithMobile.
  ///
  /// In en, this message translates to:
  /// **'Login with mobile number'**
  String get loginWithMobile;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your Iranian mobile number to receive a verification code'**
  String get loginSubtitle;

  /// No description provided for @mobileNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumberLabel;

  /// No description provided for @mobileNumberHint.
  ///
  /// In en, this message translates to:
  /// **'09XXXXXXXXX'**
  String get mobileNumberHint;

  /// No description provided for @invalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number (09XXXXXXXXX)'**
  String get invalidMobileNumber;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendOtp;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to {mobile}'**
  String otpSubtitle(String mobile);

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get verifyOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendOtp;

  /// No description provided for @otpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent'**
  String get otpSentSuccess;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit verification code'**
  String get otpInvalid;

  /// No description provided for @navRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get navRecipes;

  /// No description provided for @navGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get navGenerate;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @recipesTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipesTabTitle;

  /// No description provided for @recipesTabDescription.
  ///
  /// In en, this message translates to:
  /// **'Recipe list and search — Phase 9'**
  String get recipesTabDescription;

  /// No description provided for @generateTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate Recipe'**
  String get generateTabTitle;

  /// No description provided for @generateTabDescription.
  ///
  /// In en, this message translates to:
  /// **'AI recipe generation — Phase 8'**
  String get generateTabDescription;

  /// No description provided for @favoritesTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTabTitle;

  /// No description provided for @favoritesTabDescription.
  ///
  /// In en, this message translates to:
  /// **'Favorite recipes — Phase 10'**
  String get favoritesTabDescription;

  /// No description provided for @profileTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTabTitle;

  /// No description provided for @profileTabDescription.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings — Phase 6'**
  String get profileTabDescription;

  /// No description provided for @displayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayNameLabel;

  /// No description provided for @displayNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get displayNameHint;

  /// No description provided for @displayNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Display name is required'**
  String get displayNameRequired;

  /// No description provided for @noDisplayName.
  ///
  /// In en, this message translates to:
  /// **'No name set'**
  String get noDisplayName;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveProfile;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Route not found: {path}'**
  String routeNotFound(String path);

  /// No description provided for @managePreferences.
  ///
  /// In en, this message translates to:
  /// **'Dietary preferences'**
  String get managePreferences;

  /// No description provided for @preferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesTitle;

  /// No description provided for @preferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose dietary restrictions and cuisines you prefer. These help personalize recipe suggestions.'**
  String get preferencesSubtitle;

  /// No description provided for @preferencesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'You have not set preferences yet. Select options below and save.'**
  String get preferencesEmptyHint;

  /// No description provided for @dietaryRestrictionsSection.
  ///
  /// In en, this message translates to:
  /// **'Dietary restrictions'**
  String get dietaryRestrictionsSection;

  /// No description provided for @preferredCuisinesSection.
  ///
  /// In en, this message translates to:
  /// **'Preferred cuisines'**
  String get preferredCuisinesSection;

  /// No description provided for @savePreferences.
  ///
  /// In en, this message translates to:
  /// **'Save preferences'**
  String get savePreferences;

  /// No description provided for @deletePreferences.
  ///
  /// In en, this message translates to:
  /// **'Delete preferences'**
  String get deletePreferences;

  /// No description provided for @deletePreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete preferences'**
  String get deletePreferencesTitle;

  /// No description provided for @deletePreferencesConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your preferences?'**
  String get deletePreferencesConfirmation;

  /// No description provided for @preferencesSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Preferences saved successfully'**
  String get preferencesSavedSuccess;

  /// No description provided for @preferencesDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Preferences deleted successfully'**
  String get preferencesDeletedSuccess;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dietaryVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get dietaryVegan;

  /// No description provided for @dietaryVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get dietaryVegetarian;

  /// No description provided for @dietaryGlutenFree.
  ///
  /// In en, this message translates to:
  /// **'Gluten-free'**
  String get dietaryGlutenFree;

  /// No description provided for @dietaryDairyFree.
  ///
  /// In en, this message translates to:
  /// **'Dairy-free'**
  String get dietaryDairyFree;

  /// No description provided for @dietaryHalal.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get dietaryHalal;

  /// No description provided for @dietaryLowCarb.
  ///
  /// In en, this message translates to:
  /// **'Low-carb'**
  String get dietaryLowCarb;

  /// No description provided for @dietaryNutFree.
  ///
  /// In en, this message translates to:
  /// **'Nut-free'**
  String get dietaryNutFree;

  /// No description provided for @cuisinePersian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get cuisinePersian;

  /// No description provided for @cuisineItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get cuisineItalian;

  /// No description provided for @cuisineMediterranean.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean'**
  String get cuisineMediterranean;

  /// No description provided for @cuisineIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get cuisineIndian;

  /// No description provided for @cuisineChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get cuisineChinese;

  /// No description provided for @cuisineMexican.
  ///
  /// In en, this message translates to:
  /// **'Mexican'**
  String get cuisineMexican;

  /// No description provided for @cuisineTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get cuisineTurkish;

  /// No description provided for @cuisineFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get cuisineFrench;

  /// No description provided for @generateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one constraint: country, diet, ingredients, calories, servings, or notes.'**
  String get generateSubtitle;

  /// No description provided for @countriesSection.
  ///
  /// In en, this message translates to:
  /// **'Country / cuisine'**
  String get countriesSection;

  /// No description provided for @dietaryPreferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Dietary preferences'**
  String get dietaryPreferencesSection;

  /// No description provided for @generateConstraintRequired.
  ///
  /// In en, this message translates to:
  /// **'Select at least one constraint to generate a recipe'**
  String get generateConstraintRequired;

  /// No description provided for @exclusionsSection.
  ///
  /// In en, this message translates to:
  /// **'Exclusions'**
  String get exclusionsSection;

  /// No description provided for @exclusionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. chicken rice'**
  String get exclusionHint;

  /// No description provided for @exclusionFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Item {index}'**
  String exclusionFieldLabel(int index);

  /// No description provided for @addExclusion.
  ///
  /// In en, this message translates to:
  /// **'Add exclusion'**
  String get addExclusion;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. light meal, not spicy'**
  String get notesHint;

  /// No description provided for @ingredientsSection.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredientsSection;

  /// No description provided for @ingredientHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. tomato'**
  String get ingredientHint;

  /// No description provided for @ingredientFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Ingredient {index}'**
  String ingredientFieldLabel(int index);

  /// No description provided for @addIngredient.
  ///
  /// In en, this message translates to:
  /// **'Add ingredient'**
  String get addIngredient;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeItem;

  /// No description provided for @ingredientsRequired.
  ///
  /// In en, this message translates to:
  /// **'Add at least one ingredient'**
  String get ingredientsRequired;

  /// No description provided for @showOptionalFields.
  ///
  /// In en, this message translates to:
  /// **'Optional constraints'**
  String get showOptionalFields;

  /// No description provided for @toolsSection.
  ///
  /// In en, this message translates to:
  /// **'Available tools'**
  String get toolsSection;

  /// No description provided for @toolHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. pan'**
  String get toolHint;

  /// No description provided for @toolFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Tool {index}'**
  String toolFieldLabel(int index);

  /// No description provided for @addTool.
  ///
  /// In en, this message translates to:
  /// **'Add tool'**
  String get addTool;

  /// No description provided for @calorieLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Calorie limit'**
  String get calorieLimitLabel;

  /// No description provided for @calorieLimitHint.
  ///
  /// In en, this message translates to:
  /// **'Max calories for the whole dish'**
  String get calorieLimitHint;

  /// No description provided for @servingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Servings'**
  String get servingsLabel;

  /// No description provided for @servingsHint.
  ///
  /// In en, this message translates to:
  /// **'Number of portions'**
  String get servingsHint;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumber;

  /// No description provided for @generateRecipeButton.
  ///
  /// In en, this message translates to:
  /// **'Generate recipe'**
  String get generateRecipeButton;

  /// No description provided for @generatingRecipe.
  ///
  /// In en, this message translates to:
  /// **'Generating recipe…'**
  String get generatingRecipe;

  /// No description provided for @aiProviderFailure.
  ///
  /// In en, this message translates to:
  /// **'AI service is temporarily unavailable. Please try again.'**
  String get aiProviderFailure;

  /// No description provided for @persianOnlyAllowed.
  ///
  /// In en, this message translates to:
  /// **'Only Persian text is allowed (Persian or English digits are OK)'**
  String get persianOnlyAllowed;

  /// No description provided for @moderationNonPersianTitle.
  ///
  /// In en, this message translates to:
  /// **'Write in Persian only'**
  String get moderationNonPersianTitle;

  /// No description provided for @moderationForbiddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate ingredient'**
  String get moderationForbiddenTitle;

  /// No description provided for @editIngredientsButton.
  ///
  /// In en, this message translates to:
  /// **'Edit ingredients'**
  String get editIngredientsButton;

  /// No description provided for @recipeDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipeDetailTitle;

  /// No description provided for @descriptionSection.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionSection;

  /// No description provided for @instructionsSection.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructionsSection;

  /// No description provided for @noIngredients.
  ///
  /// In en, this message translates to:
  /// **'No ingredients listed'**
  String get noIngredients;

  /// No description provided for @noInstructions.
  ///
  /// In en, this message translates to:
  /// **'No instructions listed'**
  String get noInstructions;

  /// No description provided for @prepTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Prep: {minutes} min'**
  String prepTimeLabel(int minutes);

  /// No description provided for @cookTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Cook: {minutes} min'**
  String cookTimeLabel(int minutes);

  /// No description provided for @servingsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} servings'**
  String servingsCountLabel(int count);

  /// No description provided for @caloriesLabel.
  ///
  /// In en, this message translates to:
  /// **'{calories} kcal'**
  String caloriesLabel(int calories);

  /// No description provided for @searchRecipesHint.
  ///
  /// In en, this message translates to:
  /// **'Search recipes…'**
  String get searchRecipesHint;

  /// No description provided for @categoryFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryFilterLabel;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get categoryAll;

  /// No description provided for @categoryMainDish.
  ///
  /// In en, this message translates to:
  /// **'Main dish'**
  String get categoryMainDish;

  /// No description provided for @categoryAppetizer.
  ///
  /// In en, this message translates to:
  /// **'Appetizer'**
  String get categoryAppetizer;

  /// No description provided for @categoryDessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get categoryDessert;

  /// No description provided for @categorySoup.
  ///
  /// In en, this message translates to:
  /// **'Soup'**
  String get categorySoup;

  /// No description provided for @categorySalad.
  ///
  /// In en, this message translates to:
  /// **'Salad'**
  String get categorySalad;

  /// No description provided for @categoryStew.
  ///
  /// In en, this message translates to:
  /// **'Stew'**
  String get categoryStew;

  /// No description provided for @noRecipesFound.
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get noRecipesFound;

  /// No description provided for @totalTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min total'**
  String totalTimeLabel(int minutes);

  /// No description provided for @noFavoritesFound.
  ///
  /// In en, this message translates to:
  /// **'No favorite recipes yet'**
  String get noFavoritesFound;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get networkError;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
