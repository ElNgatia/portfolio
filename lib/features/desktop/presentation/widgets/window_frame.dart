import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

const _kEdgeSize = 6.0;
const _kCornerSize = 14.0;

// Windows 7 Aero colour palette
const _kWin7ActiveTitleTop = Color(0xFF74B2E0);
const _kWin7ActiveTitleBottom = Color(0xFF2567A5);
const _kWin7InactiveTitleTop = Color(0xFFBFCDDB);
const _kWin7InactiveTitleBottom = Color(0xFF8FA8C0);
const _kWin7BorderActive = Color(0xFF6AA0CE);
const _kWin7BorderInactive = Color(0xFFABBECE);
const _kWin7TitleBarHeight = 32.0;

class WindowFrame extends ConsumerWidget {
  final String windowId;
  final String title;
  final Icon windowIcon;
  final Widget child;

  const WindowFrame({
    super.key,
    required this.windowId,
    required this.title,
    required this.windowIcon,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wm = ref.watch(windowManagerProvider.notifier);
    final state = ref.watch(windowManagerProvider.select((s) => s[windowId]));
    final viewportSize = MediaQuery.of(context).size;

    final width = state?.size.width ?? 600;
    final height = state?.size.height ?? 400;
    final isMaximized = state?.isMaximized ?? false;

    return Positioned(
      left: state?.position.dx ?? 100,
      top: state?.position.dy ?? 100,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Main window content
            Positioned.fill(
              child: GestureDetector(
                onTapDown: (_) {
                  if (!(state?.isFocused ?? false)) {
                    wm.focusWindow(windowId);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: (state?.isFocused ?? false)
                          ? _kWin7BorderActive
                          : _kWin7BorderInactive,
                      width: 1.5,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (state?.isFocused ?? false)
                            ? Colors.black38
                            : Colors.black12,
                        blurRadius: (state?.isFocused ?? false) ? 16 : 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          key: ValueKey('titlebar_$windowId'),
                          onDoubleTap: () =>
                              wm.maximizeWindow(windowId, viewportSize),
                          onPanEnd: (_) => wm.focusWindow(windowId),
                          onPanUpdate: isMaximized
                              ? null
                              : (d) => wm.moveWindow(
                                    windowId,
                                    d.delta,
                                    viewportSize: viewportSize,
                                  ),
                          child: _TitleBar(
                            windowId: windowId,
                            title: title,
                            icon: windowIcon,
                          ),
                        ),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Resize handles — hidden when maximized
            if (!isMaximized) ...[
              // Right edge
              Positioned(
                right: 0,
                top: _kCornerSize,
                bottom: _kCornerSize,
                width: _kEdgeSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: d.delta.dx,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Left edge
              Positioned(
                left: 0,
                top: _kCornerSize,
                bottom: _kCornerSize,
                width: _kEdgeSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: -d.delta.dx,
                    fromLeft: true,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Bottom edge
              Positioned(
                bottom: 0,
                left: _kCornerSize,
                right: _kCornerSize,
                height: _kEdgeSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpDown,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    heightDelta: d.delta.dy,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Top edge
              Positioned(
                top: 0,
                left: _kCornerSize,
                right: _kCornerSize,
                height: _kEdgeSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpDown,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    heightDelta: -d.delta.dy,
                    fromTop: true,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Bottom-right corner
              Positioned(
                right: 0,
                bottom: 0,
                width: _kCornerSize,
                height: _kCornerSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: d.delta.dx,
                    heightDelta: d.delta.dy,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Bottom-left corner
              Positioned(
                left: 0,
                bottom: 0,
                width: _kCornerSize,
                height: _kCornerSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: -d.delta.dx,
                    heightDelta: d.delta.dy,
                    fromLeft: true,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Top-right corner
              Positioned(
                right: 0,
                top: 0,
                width: _kCornerSize,
                height: _kCornerSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: d.delta.dx,
                    heightDelta: -d.delta.dy,
                    fromTop: true,
                    viewportSize: viewportSize,
                  ),
                ),
              ),

              // Top-left corner
              Positioned(
                left: 0,
                top: 0,
                width: _kCornerSize,
                height: _kCornerSize,
                child: _ResizeHandle(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  onPanStart: () => wm.focusWindow(windowId),
                  onPanUpdate: (d) => wm.resizeWindow(
                    windowId,
                    widthDelta: -d.delta.dx,
                    heightDelta: -d.delta.dy,
                    fromLeft: true,
                    fromTop: true,
                    viewportSize: viewportSize,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResizeHandle extends StatelessWidget {
  const _ResizeHandle({
    required this.cursor,
    required this.onPanStart,
    required this.onPanUpdate,
  });

  final MouseCursor cursor;
  final VoidCallback onPanStart;
  final void Function(DragUpdateDetails) onPanUpdate;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        onPanStart: (_) => onPanStart(),
        onPanUpdate: onPanUpdate,
        behavior: HitTestBehavior.opaque,
      ),
    );
  }
}

class _TitleBar extends ConsumerWidget {
  const _TitleBar({
    required this.windowId,
    required this.title,
    required this.icon,
  });
  final String windowId;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMaximized = ref.watch(
      windowManagerProvider.select((s) => s[windowId]?.isMaximized ?? false),
    );
    final isFocused = ref.watch(
      windowManagerProvider.select((s) => s[windowId]?.isFocused ?? false),
    );

    return Container(
      width: double.infinity,
      height: _kWin7TitleBarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isFocused
              ? [_kWin7ActiveTitleTop, _kWin7ActiveTitleBottom]
              : [_kWin7InactiveTitleTop, _kWin7InactiveTitleBottom],
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          IconTheme(
            data: const IconThemeData(size: 16, color: Colors.white),
            child: icon,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isFocused ? Colors.white : const Color(0xFFDDEEFF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                shadows: isFocused
                    ? const [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
            ),
          ),
          _Win7TitleButton(
            key: ValueKey('minimize_$windowId'),
            icon: Icons.remove,
            tooltip: 'Minimize',
            isFocused: isFocused,
            onPressed: () => ref
                .read(windowManagerProvider.notifier)
                .minimizeWindow(windowId),
          ),
          _Win7TitleButton(
            key: ValueKey('maximize_$windowId'),
            icon: isMaximized
                ? Icons.filter_none_outlined
                : Icons.crop_square_outlined,
            tooltip: isMaximized ? 'Restore' : 'Maximize',
            isFocused: isFocused,
            onPressed: () => ref
                .read(windowManagerProvider.notifier)
                .maximizeWindow(windowId, MediaQuery.of(context).size),
          ),
          _Win7CloseButton(
            key: ValueKey('close_$windowId'),
            onPressed: () =>
                ref.read(windowManagerProvider.notifier).closeWindow(windowId),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}

/// A Windows 7-style minimize/maximize title-bar button.
class _Win7TitleButton extends StatefulWidget {
  const _Win7TitleButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.isFocused,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final bool isFocused;
  final VoidCallback onPressed;

  @override
  State<_Win7TitleButton> createState() => _Win7TitleButtonState();
}

class _Win7TitleButtonState extends State<_Win7TitleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: 26,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
            decoration: BoxDecoration(
              gradient: _hovered
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFAAD0F0), Color(0xFF5599CC)],
                    )
                  : null,
              borderRadius: BorderRadius.circular(3),
              border: _hovered
                  ? Border.all(
                      color: const Color(0xFF3D80BB),
                      width: 0.8,
                    )
                  : null,
            ),
            child: Icon(
              widget.icon,
              size: 12,
              color: widget.isFocused ? Colors.white : const Color(0xFFDDEEFF),
            ),
          ),
        ),
      ),
    );
  }
}

/// A Windows 7-style close button (red on hover).
class _Win7CloseButton extends StatefulWidget {
  const _Win7CloseButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_Win7CloseButton> createState() => _Win7CloseButtonState();
}

class _Win7CloseButtonState extends State<_Win7CloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Close',
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: 26,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
            decoration: BoxDecoration(
              gradient: _hovered
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEA6153), Color(0xFFBF1A0B)],
                    )
                  : null,
              borderRadius: BorderRadius.circular(3),
              border: _hovered
                  ? Border.all(
                      color: const Color(0xFF8B1A0A),
                      width: 0.8,
                    )
                  : null,
            ),
            child: const Icon(Icons.close, size: 12, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
