import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/shared/domain/enums/placeholder_tab.dart';

class PlaceholderTabScreen extends StatelessWidget {
  const PlaceholderTabScreen({
    required this.tab,
    required this.icon,
    super.key,
  });

  final PlaceholderTab tab;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final title = _title(context);
    final description = _description(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: cPrimary),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: cTextSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _title(BuildContext context) {
    return switch (tab) {
      PlaceholderTab.recipes => context.tr.recipesTabTitle,
      PlaceholderTab.generate => context.tr.generateTabTitle,
      PlaceholderTab.favorites => context.tr.favoritesTabTitle,
      PlaceholderTab.profile => context.tr.profileTabTitle,
    };
  }

  String _description(BuildContext context) {
    return switch (tab) {
      PlaceholderTab.recipes => context.tr.recipesTabDescription,
      PlaceholderTab.generate => context.tr.generateTabDescription,
      PlaceholderTab.favorites => context.tr.favoritesTabDescription,
      PlaceholderTab.profile => context.tr.profileTabDescription,
    };
  }
}
