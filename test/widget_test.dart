import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/app.dart';
import 'package:what_2_eat/core/constants/constants.dart';

void main() {
  testWidgets('Splash screen shows app name', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: What2EatApp(),
      ),
    );

    expect(find.text(Constants.appNamePersian), findsOneWidget);
    expect(find.text(Constants.appName), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();
  });
}
