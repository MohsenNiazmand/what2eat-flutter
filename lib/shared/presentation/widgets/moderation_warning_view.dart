import 'package:flutter/material.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

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
    final theme = Theme.of(context);
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
              color: theme.colorScheme.tertiary,
            ),
            Gap.v24(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            Gap.v12(),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Gap.v32(),
            AppPrimaryButton(
              label: context.tr.editIngredientsButton,
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}
