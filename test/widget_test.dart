import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('app boots and shows the hero tagline and desktop icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // The taskbar clock's periodic timer would keep the test alive.
          nowProvider.overrideWith((ref) => Stream.value(DateTime(2026, 1, 1))),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Case Studies'), findsOneWidget);
    expect(find.text('Open Source'), findsOneWidget);
    expect(find.text('Products'), findsOneWidget);

    expect(
      find.textContaining('Building reliable mobile software'),
      findsOneWidget,
    );
  });
}
