import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';
import 'package:portfolio/main.dart';

Future<void> _pumpDesktopApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1280, 800);
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

  // Open the start menu from the taskbar.
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('start menu lists all programs, user rail and shut down',
      (tester) async {
    await _pumpDesktopApp(tester);

    for (final id in [
      '123', // About Me
      '234', // Case Studies
      '567', // Open Source
      '456', // Products
      '789', // Experience
      '012', // Contact
      '345', // Resume
      '678', // Settings
      '901', // Browser
    ]) {
      expect(find.byKey(ValueKey('start_menu_$id')), findsOneWidget);
    }

    expect(find.text('Elvis Ngatia'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Shut Down'), findsOneWidget);
  });

  testWidgets('search filters the program list', (tester) async {
    await _pumpDesktopApp(tester);

    await tester.enterText(
      find.byKey(const ValueKey('start_menu_search')),
      'case',
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('start_menu_234')), findsOneWidget);
    expect(find.byKey(const ValueKey('start_menu_123')), findsNothing);
  });

  testWidgets('tapping a program opens its window and closes the menu',
      (tester) async {
    await _pumpDesktopApp(tester);

    await tester.tap(find.byKey(const ValueKey('start_menu_123')));
    await tester.pumpAndSettle();

    // Menu is gone; the About Me window frame is open.
    expect(find.byKey(const ValueKey('titlebar_123')), findsOneWidget);
    expect(find.byKey(const ValueKey('start_menu_search')), findsNothing);
  });

  testWidgets('shut down closes the menu', (tester) async {
    await _pumpDesktopApp(tester);

    await tester.tap(find.byKey(const ValueKey('start_menu_shutdown')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('start_menu_search')), findsNothing);
    expect(find.byKey(const ValueKey('titlebar_123')), findsNothing);
  });
}
