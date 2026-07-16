import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/auth/domain/enums/auth_status.dart';
import 'package:what_2_eat/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:what_2_eat/features/auth/presentation/screens/login_screen.dart';
import 'package:what_2_eat/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:what_2_eat/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:what_2_eat/features/main/presentation/screens/main_shell_screen.dart';
import 'package:what_2_eat/features/profile/presentation/screens/profile_screen.dart';
import 'package:what_2_eat/features/recipes/presentation/models/recipe_detail_navigation.dart';
import 'package:what_2_eat/features/recipes/presentation/screens/generate_recipe_screen.dart';
import 'package:what_2_eat/features/recipes/presentation/screens/recipe_detail_screen.dart';
import 'package:what_2_eat/features/recipes/presentation/screens/recipe_list_screen.dart';
import 'package:what_2_eat/features/splash/presentation/screens/splash_screen.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'go_router_provider.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authListenable = ValueNotifier(ref.read(authStateProvider));

  ref
    ..listen(authStateProvider, (_, next) {
      authListenable.value = next;
    })
    ..onDispose(authListenable.dispose);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final status = authListenable.value;
      final path = state.uri.path;

      if (status == AuthStatus.initial) {
        return path == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (path == AppRoutes.splash) {
        return status == AuthStatus.authenticated
            ? AppRoutes.home
            : AppRoutes.login;
      }

      final isAuthRoute =
          path == AppRoutes.login || path == AppRoutes.otpVerification;

      if (status == AuthStatus.unauthenticated && !isAuthRoute) {
        return AppRoutes.login;
      }

      if (status == AuthStatus.authenticated && isAuthRoute) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final mobile = state.uri.queryParameters['mobile'] ?? '';
          return OtpVerificationScreen(mobileNumber: mobile);
        },
      ),
      GoRoute(
        path: AppRoutes.recipeDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra;
          Recipe? initialRecipe;
          var resolveFavoriteStatus = true;

          if (extra is RecipeDetailNavigation) {
            initialRecipe = extra.recipe;
            resolveFavoriteStatus = extra.resolveFavoriteStatus;
          } else if (extra is Recipe) {
            initialRecipe = extra;
          }

          return RecipeDetailScreen(
            recipeId: id,
            initialRecipe: initialRecipe,
            resolveFavoriteStatus: resolveFavoriteStatus,
          );
        },
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
                builder: (context, state) => const RecipeListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.generate,
                builder: (context, state) => const GenerateRecipeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
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
