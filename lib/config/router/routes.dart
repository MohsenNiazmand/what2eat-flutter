class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String otpVerification = '/otp-verify';
  static const String home = '/home';
  static const String generate = '/generate';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String preferences = '/preferences';
  static const String recipeDetail = '/recipes/:id';

  static String recipeDetailPath(String id) => '/recipes/$id';
}
