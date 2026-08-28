import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/analytics.dart';
import 'package:portfolio/features/desktop/presentation/views/desktop_view.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      // TODO: enable capturing by adding your Sentry DSN:
      // options.dsn = 'https://<key>@<org>.ingest.sentry.io/<project>';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () async {
      await initFirebaseAnalytics();
      runApp(ProviderScope(child: const MyApp()));
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elvis Ngatia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(body: DesktopView()),
    );
  }
}

/// Initialises Firebase + Analytics. If Firebase isn't configured yet (the
/// placeholder options in firebase_options.dart), it silently skips analytics
/// so the app still runs normally.
Future<void> initFirebaseAnalytics() async {
  try {
    await Firebase.initializeApp(options: firebaseWebOptions);
    Analytics.init(FirebaseAnalytics.instance);
    await Analytics.logAppOpen();
  } catch (e) {
    // If Firebase isn't configured yet (placeholders), the app still runs —
    // only analytics are skipped.
  }
}
