import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

const _kEdgeSize = 6.0;
const _kCornerSize = 14.0;

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
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.blueGrey),
                    boxShadow: [
                      if (state?.isFocused ?? false)
                        const BoxShadow(blurRadius: 12, color: Colors.black26),
                    ],
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
    return Container(
      width: double.infinity,
      color: Colors.blueGrey,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          IconButton(
            key: ValueKey('minimize_$windowId'),
            icon: const Icon(Icons.minimize),
            onPressed: () => ref
                .read(windowManagerProvider.notifier)
                .minimizeWindow(windowId),
          ),
          IconButton(
            key: ValueKey('maximize_$windowId'),
            tooltip: isMaximized ? 'Restore' : 'Maximize',
            icon: Icon(
              isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
            ),
            onPressed: () => ref
                .read(windowManagerProvider.notifier)
                .maximizeWindow(windowId, MediaQuery.of(context).size),
          ),
          IconButton(
            key: ValueKey('close_$windowId'),
            icon: const Icon(Icons.close),
            onPressed: () =>
                ref.read(windowManagerProvider.notifier).closeWindow(windowId),
          ),
        ],
      ),
    );
  }
}
