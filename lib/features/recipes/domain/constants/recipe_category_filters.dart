class RecipeCategoryOption {
  const RecipeCategoryOption(this.apiValue);

  final String apiValue;
}

abstract final class RecipeCategoryFilters {
  static const mainDish = RecipeCategoryOption('غذای اصلی');
  static const appetizer = RecipeCategoryOption('پیش‌غذا');
  static const dessert = RecipeCategoryOption('دسر');
  static const soup = RecipeCategoryOption('سوپ');
  static const salad = RecipeCategoryOption('سالاد');
  static const stew = RecipeCategoryOption('خورشت');

  static const all = [
    mainDish,
    appetizer,
    dessert,
    soup,
    salad,
    stew,
  ];
}
