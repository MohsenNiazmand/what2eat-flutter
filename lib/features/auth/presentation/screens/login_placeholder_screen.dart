import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
class LoginPlaceholderScreen extends HookConsumerWidget {
  const LoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود')),
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
              'ورود با شماره موبایل',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cTextPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'صفحه ورود OTP در Phase 5 پیاده‌سازی می‌شود',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cTextSecondary,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('ادامه (موقت)'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
