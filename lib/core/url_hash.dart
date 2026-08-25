// Conditional URL-hash access: real implementation on the web, no-op
// elsewhere so desktop/mobile builds are unaffected.
export 'url_hash_stub.dart' if (dart.library.js_interop) 'url_hash_web.dart';
