// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WindowManager)
const windowManagerProvider = WindowManagerProvider._();

final class WindowManagerProvider
    extends $NotifierProvider<WindowManager, Map<String, WindowEntity>> {
  const WindowManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windowManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windowManagerHash();

  @$internal
  @override
  WindowManager create() => WindowManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, WindowEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, WindowEntity>>(value),
    );
  }
}

String _$windowManagerHash() => r'0775a14666cef0f9677d0c0c90751f999ae0fe6a';

abstract class _$WindowManager extends $Notifier<Map<String, WindowEntity>> {
  Map<String, WindowEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<Map<String, WindowEntity>, Map<String, WindowEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, WindowEntity>, Map<String, WindowEntity>>,
              Map<String, WindowEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
