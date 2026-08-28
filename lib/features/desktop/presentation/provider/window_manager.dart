import 'dart:math' as math;
import 'dart:ui';

import 'package:portfolio/core/analytics.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/core/window_routes.dart';
import 'package:portfolio/features/desktop/domain/entity/desktop_icon.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_manager.g.dart';

const _minWindowWidth = 300.0;
const _minWindowHeight = 200.0;

@riverpod
class WindowManager extends _$WindowManager {
  @override
  Map<String, WindowEntity> build() => {};

  /// Opens the window for [icon], sized and positioned for [viewport].
  /// Shared by desktop-icon taps and deep-link navigation.
  void openApp(DesktopIcon icon, Size viewport) {
    final isMobile = viewport.width < kMobileBreakpoint;

    // Clamp window size so it never exceeds the available viewport area.
    final windowWidth = math.min(600.0, viewport.width);
    final windowHeight = math.min(400.0, viewport.height - kTaskbarHeight);
    final windowSize = Size(windowWidth, windowHeight);

    final center =
        viewport.center(Offset.zero) -
        Offset(windowSize.width / 2, windowSize.height / 2);

    openWindow(
      WindowEntity(
        id: icon.id,
        icon: icon.icon,
        title: icon.title,
        // On mobile open maximised; keep restore state so the user can
        // un-maximise to a sensibly-sized floating window.
        position: isMobile ? Offset.zero : center,
        size: isMobile
            ? Size(viewport.width, viewport.height - kTaskbarHeight)
            : windowSize,
        isMaximized: isMobile,
        preMaximizePosition: isMobile ? center : null,
        preMaximizeSize: isMobile ? windowSize : null,
      ),
    );
  }

  void openWindow(WindowEntity window) {
    state = {
      ...state,
      window.id: window.copyWith(isOpen: true, isFocused: true),
    };
    _bringToFront(window.id);
    // Fire-and-forget analytics for the opened section (only if enabled).
    final slug = windowIdToSlug(window.id);
    if (slug != null) {
      Analytics.logSectionOpen(window.id, slug);
    }
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

  void moveWindow(String id, Offset delta, {Size? viewportSize}) {
    final win = state[id];
    if (win == null || win.isMaximized) return;

    double newX = win.position.dx + delta.dx;
    double newY = win.position.dy + delta.dy;

    if (viewportSize != null) {
      const minVisible = 40.0;
      newX = newX.clamp(
        -win.size.width + minVisible,
        viewportSize.width - minVisible,
      );
      newY = newY.clamp(
        0.0,
        viewportSize.height - kTaskbarHeight - minVisible,
      );
    }

    state = {
      ...state,
      id: win.copyWith(position: Offset(newX, newY)),
    };
  }

  void resizeWindow(
    String id, {
    double widthDelta = 0,
    double heightDelta = 0,
    bool fromLeft = false,
    bool fromTop = false,
    Size? viewportSize,
  }) {
    final win = state[id];
    if (win == null || win.isMaximized) return;

    double newWidth =
        (win.size.width + widthDelta).clamp(_minWindowWidth, double.infinity).toDouble();
    double newHeight =
        (win.size.height + heightDelta).clamp(_minWindowHeight, double.infinity).toDouble();

    double posX = win.position.dx;
    double posY = win.position.dy;

    if (fromLeft) posX += win.size.width - newWidth;
    if (fromTop) posY += win.size.height - newHeight;

    if (viewportSize != null) {
      final maxRight = viewportSize.width;
      final maxBottom = viewportSize.height - kTaskbarHeight;

      if (fromLeft) {
        posX = posX.clamp(
          0.0,
          win.position.dx + win.size.width - _minWindowWidth,
        );
        newWidth = win.position.dx + win.size.width - posX;
      } else {
        newWidth = newWidth.clamp(
          _minWindowWidth,
          math.max(_minWindowWidth, maxRight - posX),
        );
      }

      if (fromTop) {
        posY = posY.clamp(
          0.0,
          win.position.dy + win.size.height - _minWindowHeight,
        );
        newHeight = win.position.dy + win.size.height - posY;
      } else {
        newHeight = newHeight.clamp(
          _minWindowHeight,
          math.max(_minWindowHeight, maxBottom - posY),
        );
      }
    }

    state = {
      ...state,
      id: win.copyWith(
        position: Offset(posX, posY),
        size: Size(newWidth, newHeight),
      ),
    };
  }

  void maximizeWindow(String id, Size viewportSize) {
    final win = state[id];
    if (win == null) return;

    if (win.isMaximized) {
      state = {
        ...state,
        id: win.copyWith(
          isMaximized: false,
          position: win.preMaximizePosition ?? win.position,
          size: win.preMaximizeSize ?? win.size,
          clearPreMaximize: true,
        ),
      };
    } else {
      state = {
        ...state,
        id: win.copyWith(
          isMaximized: true,
          preMaximizePosition: win.position,
          preMaximizeSize: win.size,
          position: Offset.zero,
          size: Size(viewportSize.width, viewportSize.height - kTaskbarHeight),
        ),
      };
    }
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
