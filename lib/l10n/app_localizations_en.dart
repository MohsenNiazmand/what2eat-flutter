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

  @override
  String get managePreferences => 'Dietary preferences';

  @override
  String get preferencesTitle => 'Preferences';

  @override
  String get preferencesSubtitle =>
      'Choose dietary restrictions and cuisines you prefer. These help personalize recipe suggestions.';

  @override
  String get preferencesEmptyHint =>
      'You have not set preferences yet. Select options below and save.';

  @override
  String get dietaryRestrictionsSection => 'Dietary restrictions';

  @override
  String get preferredCuisinesSection => 'Preferred cuisines';

  @override
  String get savePreferences => 'Save preferences';

  @override
  String get deletePreferences => 'Delete preferences';

  @override
  String get deletePreferencesTitle => 'Delete preferences';

  @override
  String get deletePreferencesConfirmation =>
      'Are you sure you want to delete your preferences?';

  @override
  String get preferencesSavedSuccess => 'Preferences saved successfully';

  @override
  String get preferencesDeletedSuccess => 'Preferences deleted successfully';

  @override
  String get retry => 'Retry';

  @override
  String get dietaryVegan => 'Vegan';

  @override
  String get dietaryVegetarian => 'Vegetarian';

  @override
  String get dietaryGlutenFree => 'Gluten-free';

  @override
  String get dietaryDairyFree => 'Dairy-free';

  @override
  String get dietaryHalal => 'Halal';

  @override
  String get dietaryLowCarb => 'Low-carb';

  @override
  String get dietaryNutFree => 'Nut-free';

  @override
  String get cuisinePersian => 'Persian';

  @override
  String get cuisineItalian => 'Italian';

  @override
  String get cuisineMediterranean => 'Mediterranean';

  @override
  String get cuisineIndian => 'Indian';

  @override
  String get cuisineChinese => 'Chinese';

  @override
  String get cuisineMexican => 'Mexican';

  @override
  String get cuisineTurkish => 'Turkish';

  @override
  String get cuisineFrench => 'French';

  @override
  String get generateSubtitle =>
      'Enter the ingredients you have available. AI will suggest a Persian recipe.';

  @override
  String get ingredientsSection => 'Ingredients';

  @override
  String get ingredientHint => 'e.g. tomato';

  @override
  String ingredientFieldLabel(int index) {
    return 'Ingredient $index';
  }

  @override
  String get addIngredient => 'Add ingredient';

  @override
  String get removeItem => 'Remove';

  @override
  String get ingredientsRequired => 'Add at least one ingredient';

  @override
  String get showOptionalFields => 'Optional constraints';

  @override
  String get toolsSection => 'Available tools';

  @override
  String get toolHint => 'e.g. pan';

  @override
  String toolFieldLabel(int index) {
    return 'Tool $index';
  }

  @override
  String get addTool => 'Add tool';

  @override
  String get calorieLimitLabel => 'Calorie limit';

  @override
  String get calorieLimitHint => 'Max calories for the whole dish';

  @override
  String get servingsLabel => 'Servings';

  @override
  String get servingsHint => 'Number of portions';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get generateRecipeButton => 'Generate recipe';

  @override
  String get generatingRecipe => 'Generating recipe…';

  @override
  String get aiProviderFailure =>
      'AI service is temporarily unavailable. Please try again.';

  @override
  String get recipeDetailTitle => 'Recipe';

  @override
  String get descriptionSection => 'Description';

  @override
  String get instructionsSection => 'Instructions';

  @override
  String get noIngredients => 'No ingredients listed';

  @override
  String get noInstructions => 'No instructions listed';

  @override
  String prepTimeLabel(int minutes) {
    return 'Prep: $minutes min';
  }

  @override
  String cookTimeLabel(int minutes) {
    return 'Cook: $minutes min';
  }

  @override
  String servingsCountLabel(int count) {
    return '$count servings';
  }

  @override
  String caloriesLabel(int calories) {
    return '$calories kcal';
  }

  @override
  String get searchRecipesHint => 'Search recipes…';

  @override
  String get categoryFilterLabel => 'Category';

  @override
  String get categoryAll => 'All categories';

  @override
  String get categoryMainDish => 'Main dish';

  @override
  String get categoryAppetizer => 'Appetizer';

  @override
  String get categoryDessert => 'Dessert';

  @override
  String get categorySoup => 'Soup';

  @override
  String get categorySalad => 'Salad';

  @override
  String get categoryStew => 'Stew';

  @override
  String get noRecipesFound => 'No recipes found';

  @override
  String totalTimeLabel(int minutes) {
    return '$minutes min total';
  }
}
