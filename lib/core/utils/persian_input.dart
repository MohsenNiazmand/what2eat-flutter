import 'package:flutter/services.dart';

const _persianInputPattern = r'[\u0600-\u06FF\s\u200c]';

final _persianLetterPattern = RegExp(r'[\u0600-\u06FF]');

/// Creates a formatter that allows Persian letters, spaces, and ZWNJ.
/// Calls [onRejected] when the user enters disallowed characters.
TextInputFormatter createPersianIngredientFormatter({
  VoidCallback? onRejected,
}) {
  final filter = FilteringTextInputFormatter.allow(
    RegExp(_persianInputPattern),
  );

  return TextInputFormatter.withFunction((oldValue, newValue) {
    final result = filter.formatEditUpdate(oldValue, newValue);
    if (result.text != newValue.text) {
      onRejected?.call();
    }
    return result;
  });
}

/// Returns true when [value] contains at least one Persian letter after trim.
bool isValidPersianIngredientText(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return false;
  return _persianLetterPattern.hasMatch(trimmed);
}
