import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';

class LoginPlaceholderScreen extends HookConsumerWidget {
  const LoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Icon(
              Icons.phone_android,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              context.tr.loginWithMobile,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cTextPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.loginPlaceholderHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cTextSecondary,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(context.tr.continueTemporary),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
