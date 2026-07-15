import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/features/auth/presentation/screens/login_placeholder_screen.dart';
import 'package:what_2_eat/features/main/presentation/screens/main_shell_screen.dart';
import 'package:what_2_eat/features/main/presentation/screens/placeholder_tab_screen.dart';
import 'package:what_2_eat/features/splash/presentation/screens/splash_screen.dart';

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
                  title: 'دستورهای پخت',
                  icon: Icons.restaurant_menu,
                  description: 'لیست و جستجوی دستور پخت — Phase 9',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.generate,
                builder: (context, state) => const PlaceholderTabScreen(
                  title: 'تولید دستور',
                  icon: Icons.auto_awesome,
                  description: 'تولید دستور با هوش مصنوعی — Phase 8',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const PlaceholderTabScreen(
                  title: 'علاقه‌مندی‌ها',
                  icon: Icons.favorite,
                  description: 'دستورهای مورد علاقه — Phase 10',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const PlaceholderTabScreen(
                  title: 'پروفایل',
                  icon: Icons.person,
                  description: 'پروفایل و تنظیمات — Phase 6',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('خطا')),
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
}
