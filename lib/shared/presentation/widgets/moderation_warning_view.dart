import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';

class ModerationWarningView extends StatelessWidget {
  const ModerationWarningView({
    required this.failure,
    required this.onDismiss,
    super.key,
  });

  final ModerationFailure failure;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final title = failure.isNonPersianText
        ? context.tr.moderationNonPersianTitle
        : context.tr.moderationForbiddenTitle;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: cTextSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onDismiss,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(context.tr.editIngredientsButton),
            ),
          ],
        ),
      ),
    );
  }
}
