import 'dart:ui';

import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_manager.g.dart';

const _minWindowWidth = 300.0;
const _minWindowHeight = 200.0;

@riverpod
class WindowManager extends _$WindowManager {
  @override
  Map<String, WindowEntity> build() => {};

  void openWindow(WindowEntity window) {
    state = {
      ...state,
      window.id: window.copyWith(isOpen: true, isFocused: true),
    };
    _bringToFront(window.id);
  }

  void closeWindow(String id) {
    state = {...state}..remove(id);
  }

  void minimizeWindow(String id) {
    final win = state[id];
    if (win == null) return;
    state = {...state, id: state[id]!.copyWith(isMinimized: true)};
  }

  void restoreWindow(String id) {
    final win = state[id];
    if (win == null) return;
    state = {
      ...state,
      id: state[id]!.copyWith(
        isMinimized: !state[id]!.isMinimized,
        isFocused: !state[id]!.isFocused,
      ),
    };
  }

  void moveWindow(String id, Offset delta) {
    final win = state[id];
    if (win != null) {
      state = {
        ...state,
        id: win.copyWith(
          position: win.position + delta,
        ),
      };
    }
  }

  void resizeWindow(
    String id, {
    double widthDelta = 0,
    double heightDelta = 0,
    bool fromLeft = false,
    bool fromTop = false,
  }) {
    final win = state[id];
    if (win == null) return;

    final newWidth = (win.size.width + widthDelta)
        .clamp(_minWindowWidth, double.infinity)
        .toDouble();
    final newHeight = (win.size.height + heightDelta)
        .clamp(_minWindowHeight, double.infinity)
        .toDouble();

    double posX = win.position.dx;
    double posY = win.position.dy;

    if (fromLeft) posX += win.size.width - newWidth;
    if (fromTop) posY += win.size.height - newHeight;

    state = {
      ...state,
      id: win.copyWith(
        position: Offset(posX, posY),
        size: Size(newWidth, newHeight),
      ),
    };
  }

  void focusWindow(String id) => _bringToFront(id);

  void _bringToFront(String id) {
    final windows = Map<String, WindowEntity>.from(state);
    final updatedWindows = <String, WindowEntity>{};
    windows.forEach((key, win) {
      if (key != id) {
        updatedWindows[key] = win.copyWith(isFocused: false);
      }
    });

    final focusedWin = windows[id];
    if (focusedWin != null) {
      updatedWindows[id] = focusedWin.copyWith(isFocused: true);
    }
    state = updatedWindows;
  }
}
