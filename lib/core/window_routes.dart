/// Maps shareable URL slugs to desktop window ids and back.
///
/// Enables deep links like `/#/case-studies` that open the matching window
/// on load, and keeps the URL fragment in sync with the focused window.
library;

const Map<String, String> slugToWindowId = {
  'about': '123',
  'case-studies': '234',
  'open-source': '567',
  'products': '456',
  'experience': '789',
  'contact': '012',
  'resume': '345',
  'settings': '678',
  'browser': '901',
};

String? windowIdToSlug(String id) {
  for (final entry in slugToWindowId.entries) {
    if (entry.value == id) return entry.key;
  }
  return null;
}

String? windowIdForSlug(String slug) => slugToWindowId[slug];
