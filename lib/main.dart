import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/app.dart';
import 'package:what_2_eat/core/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(
    const ProviderScope(
      child: What2EatApp(),
    ),
  );
}
