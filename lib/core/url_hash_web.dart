import 'package:web/web.dart' as web;

/// Reads the current URL fragment as a slug, e.g. "#/case-studies" ->
/// "case-studies". Returns null when absent.
String? readHashSlug() {
  final hash = web.window.location.hash;
  if (hash.length <= 2 || !hash.startsWith('#/')) return null;
  return hash.substring(2);
}

/// Writes [slug] to the URL fragment ("#/case-studies"); clears it when null.
void writeHashSlug(String? slug) {
  web.window.location.hash = slug == null ? '' : '/$slug';
}
