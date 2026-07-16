import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';

class MainShellScreen extends HookConsumerWidget {
  const MainShellScreen({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index, WidgetRef ref) {
    if (index == 0) {
      ref.read(recipeListNotifierProvider.notifier).refresh();
    }

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  void _handleBackPress(
    BuildContext context,
    WidgetRef ref,
    ObjectRef<DateTime?> lastBackPress,
  ) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }

    if (navigationShell.currentIndex != 0) {
      ref.read(recipeListNotifierProvider.notifier).refresh();
      navigationShell.goBranch(0);
      return;
    }

    final now = DateTime.now();
    final previousPress = lastBackPress.value;
    if (previousPress == null ||
        now.difference(previousPress) > const Duration(seconds: 2)) {
      lastBackPress.value = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(context.tr.pressBackAgainToExit),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastBackPress = useRef<DateTime?>(null);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackPress(context, ref, lastBackPress);
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTap(index, ref),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.restaurant_menu_outlined),
              selectedIcon: const Icon(Icons.restaurant_menu),
              label: context.tr.navRecipes,
            ),
            NavigationDestination(
              icon: const Icon(Icons.auto_awesome_outlined),
              selectedIcon: const Icon(Icons.auto_awesome),
              label: context.tr.navGenerate,
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_outline),
              selectedIcon: const Icon(Icons.favorite),
              label: context.tr.navFavorites,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: context.tr.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
