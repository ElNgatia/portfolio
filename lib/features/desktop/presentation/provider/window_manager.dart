import 'dart:ui';

import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_manager.g.dart';

@riverpod
class WindowManager extends _$WindowManager {
  @override
  Map<String, WindowEntity> build() => {};

  void openWindow(WindowEntity window) {
    state = {...state, window.id: window.copyWith(isOpen: true, isFocused: true)};
    _bringToFront(window.id);
  }

  void closeWindow(String id) {
    state = {...state}..remove(id);
  }

  void minimizeWindow(String id) {
    state = {...state, id: state[id]!.copyWith(isMinimized: true)};
  }

  void restoreWindow(String id) {
    state = {...state, id: state[id]!.copyWith(isMinimized: false)};
  }

  void moveWindow(String id, Offset delta) {
    final win = state[id];
    if (win != null) {
      state = {
        ...state,
        id: win.copyWith(position: win.position + delta),
      };
    }
  }

  void focusWindow(String id) => _bringToFront(id);

  void _bringToFront(String id) {
    // Optionally handle z-index ordering
  }
}
