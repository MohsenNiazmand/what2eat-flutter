import 'package:flutter/material.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/l10n/app_localizations.dart';

String recipeCategoryFilterLabel(BuildContext context, String apiValue) {
  return _recipeCategoryFilterLabel(context.tr, apiValue);
}

String _recipeCategoryFilterLabel(AppLocalizations tr, String apiValue) {
  return switch (apiValue) {
    'غذای اصلی' => tr.categoryMainDish,
    'پیش‌غذا' => tr.categoryAppetizer,
    'دسر' => tr.categoryDessert,
    'سوپ' => tr.categorySoup,
    'سالاد' => tr.categorySalad,
    'خورشت' => tr.categoryStew,
    _ => apiValue,
  };
}
