import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/app_router.dart';
import 'package:what_2_eat/config/theme/app_theme.dart';
import 'package:what_2_eat/core/constants/constants.dart';

class What2EatApp extends HookConsumerWidget {
  What2EatApp({super.key});

  final _router = AppRouter().router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
      builder: (context, child) {
        final content = botToastBuilder(context, child);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: content,
        );
      },
    );
  }
}
