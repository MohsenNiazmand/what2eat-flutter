import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/auth/presentation/screens/login_placeholder_screen.dart';
import 'package:what_2_eat/features/main/presentation/screens/main_shell_screen.dart';
import 'package:what_2_eat/features/main/presentation/screens/placeholder_tab_screen.dart';
import 'package:what_2_eat/features/splash/presentation/screens/splash_screen.dart';
import 'package:what_2_eat/shared/domain/enums/placeholder_tab.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPlaceholderScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const PlaceholderTabScreen(
                  tab: PlaceholderTab.recipes,
                  icon: Icons.restaurant_menu,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.generate,
                builder: (context, state) => const PlaceholderTabScreen(
                  tab: PlaceholderTab.generate,
                  icon: Icons.auto_awesome,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const PlaceholderTabScreen(
                  tab: PlaceholderTab.favorites,
                  icon: Icons.favorite,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const PlaceholderTabScreen(
                  tab: PlaceholderTab.profile,
                  icon: Icons.person,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(context.tr.errorTitle)),
        body: Center(
          child: Text(context.tr.routeNotFound(state.uri.toString())),
        ),
      );
    },
  );
}
