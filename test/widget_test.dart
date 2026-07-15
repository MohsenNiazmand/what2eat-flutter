import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/app.dart';

void main() {
  testWidgets('Splash screen shows localized app name', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: What2EatApp(),
      ),
    );

    expect(find.text('چی بخورم'), findsOneWidget);
    expect(find.text('What2Eat'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();
  });
}
