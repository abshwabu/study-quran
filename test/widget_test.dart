import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyquran/main.dart';

void main() {
  testWidgets('App smoke test initializes QuranResearchApp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: QuranResearchApp(),
      ),
    );

    // Verify initial splash & progress screen renders
    expect(find.text('Quran Research App'), findsOneWidget);
  });
}
