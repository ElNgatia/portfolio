import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';
import 'package:portfolio/main.dart';

Future<void> _pumpMobileApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        nowProvider.overrideWith((ref) => Stream.value(DateTime(2026, 1, 1))),
      ],
      child: const MyApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('mobile shows the Windows Phone start screen with tiles',
      (tester) async {
    await _pumpMobileApp(tester);

    // Wide "Me" tile content
    expect(find.text('Elvis Ngatia'), findsOneWidget);
    // Medium tile labels
    expect(find.text('Case Studies'), findsOneWidget);
    expect(find.text('Open Source'), findsOneWidget);
    expect(find.text('Resume'), findsOneWidget);
    // Status bar clock
    expect(find.text('00:00'), findsOneWidget);
    // No desktop taskbar on mobile
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('tapping a tile opens the app full-screen in Metro style',
      (tester) async {
    await _pumpMobileApp(tester);

    await tester.tap(find.byKey(const ValueKey('metro_tile_234')));
    await tester.pumpAndSettle();

    // Metro page header with big light title
    final metroTitle = find.byWidgetPredicate(
      (w) =>
          w is Text &&
          w.data == 'Case Studies' &&
          w.style?.fontSize == 34 &&
          w.style?.fontWeight == FontWeight.w300,
    );
    expect(metroTitle, findsOneWidget);
    // Back chevron present, no Win7 window chrome
    expect(find.byKey(const ValueKey('metro_back_234')), findsOneWidget);
    expect(find.byIcon(Icons.crop_square_outlined), findsNothing);
  });

  testWidgets('back button returns to the start screen', (tester) async {
    await _pumpMobileApp(tester);

    await tester.tap(find.byKey(const ValueKey('metro_tile_234')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('metro_back_234')));
    await tester.pumpAndSettle();

    // Back on Start: the wide About tile is visible again
    expect(find.text('Elvis Ngatia'), findsOneWidget);
  });

  testWidgets('mobile app pages render content in the dark Metro skin',
      (tester) async {
    await _pumpMobileApp(tester);

    final contactTile = find.byKey(const ValueKey('metro_tile_012'));
    await tester.scrollUntilVisible(
      contactTile,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(contactTile);
    await tester.pumpAndSettle();

    expect(find.text('GET IN TOUCH'), findsOneWidget);

    // The window content's page surface uses the Metro black background.
    final pageSurface = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('GET IN TOUCH'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(pageSurface.color, const Color(0xFF000000));
  });
}
