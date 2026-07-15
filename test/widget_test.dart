import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/app.dart';
import 'package:what_2_eat/core/injection_container.dart';

void main() {
  setUpAll(() async {
    await initializeDependencies();
  });

  testWidgets('Splash screen shows localized app name', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: What2EatApp(),
      ),
    );

    expect(find.text('چی بخورم'), findsOneWidget);
    expect(find.text('What2Eat'), findsOneWidget);
  });
}
