import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/l10n/app_localizations.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

String formatRecipeShareText({
  required Recipe recipe,
  required AppLocalizations l10n,
}) {
  final buffer = StringBuffer();

  buffer.writeln('🍲 ${recipe.title}');

  final description = recipe.description?.trim();
  if (description != null && description.isNotEmpty) {
    buffer.writeln();
    buffer.writeln(description);
  }

  if (recipe.ingredients.isNotEmpty) {
    buffer.writeln();
    buffer.writeln('📝 ${l10n.ingredientsSection}:');
    for (final ingredient in recipe.ingredients) {
      final amount = PersianDigits.toPersian(ingredient.amount);
      buffer.writeln('• ${ingredient.name} — $amount');
    }
  }

  buffer.writeln();
  buffer.writeln('👨‍🍳 ${l10n.instructionsSection}:');
  buffer.writeln(l10n.shareInstructionsNote);

  final imageUrl = recipe.image?.trim();
  if (imageUrl != null && imageUrl.isNotEmpty) {
    buffer.writeln();
    buffer.writeln('🔗 ${l10n.shareImageLinkLabel}:');
    buffer.writeln(imageUrl);
  }

  buffer.writeln();
  buffer.writeln('—');
  buffer.writeln(l10n.shareRecipeSignature);

  return buffer.toString().trim();
}
