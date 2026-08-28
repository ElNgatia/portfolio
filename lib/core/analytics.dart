import 'package:firebase_analytics/firebase_analytics.dart';

/// Lightweight wrapper around Firebase Analytics / Sentry so call sites stay
/// simple and resilient: if Firebase isn't configured (e.g. running without a
/// firebase_options, or on a platform where it's unavailable), the calls no-op
/// instead of throwing.
class Analytics {
  Analytics._();

  static FirebaseAnalytics? _analytics;

  /// Initialises the cached Firebase Analytics instance (if Firebase is up).
  static void init(FirebaseAnalytics analytics) => _analytics = analytics;

  /// Logs that the app/portfolio was opened.
  static Future<void> logAppOpen() async {
    try {
      await _analytics?.logAppOpen();
    } catch (_) {}
  }

  /// Logs a section/window being opened (e.g. "about", "projects", ...).
  static Future<void> logSectionOpen(String id, String title) async {
    try {
      await _analytics?.logEvent(
        name: 'section_open',
        parameters: {'id': id, 'title': title},
      );
    } catch (_) {}
  }

  static bool get isAvailable => _analytics != null;
}
