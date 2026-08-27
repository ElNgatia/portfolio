import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/desktop/presentation/views/media_player_window.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';
import 'package:portfolio/main.dart';

Future<void> _openMediaPlayer(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('start_menu_112')));
  await tester.pumpAndSettle();
}

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
}

void main() {
  testWidgets('media player opens with playlist and now playing',
      (tester) async {
    await _pumpDesktopApp(tester);

    // Open via the desktop icon (single tap on the icon label).
    await _openMediaPlayer(tester);

    // Now playing header shows the first track.
    expect(find.text('Neon Skyline'), findsNWidgets(2)); // header + playlist row
    expect(find.text('SoundHelix'), findsWidgets);

    // All five tracks are listed.
    for (var i = 0; i < 5; i++) {
      expect(find.byKey(ValueKey('media_player_track_$i')), findsOneWidget);
    }

    // Transport controls exist.
    expect(
      find.byKey(const ValueKey('media_player_play_pause')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('media_player_seek')), findsOneWidget);
  });

  testWidgets('selecting a playlist track switches now playing',
      (tester) async {
    await _pumpDesktopApp(tester);

    await _openMediaPlayer(tester);

    // Select the third track; playback itself is not started in tests
    // (no audio backend in the test environment).
    await tester.tap(find.byKey(const ValueKey('media_player_track_2')));
    await tester.pump();

    expect(find.text('Paper Planes'), findsNWidgets(2)); // header + playlist row
  });

  testWidgets('media player window renders inside a Win7 frame',
      (tester) async {
    await _pumpDesktopApp(tester);

    await _openMediaPlayer(tester);

    // Window frame chrome is present around the player.
    expect(find.byIcon(Icons.crop_square_outlined), findsOneWidget);
    expect(find.byType(MediaPlayerWindow), findsOneWidget);
  });
}
