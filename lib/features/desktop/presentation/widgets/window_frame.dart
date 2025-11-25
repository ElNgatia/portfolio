import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

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

    return Positioned(
      left: state?.position.dx ?? 100,
      top: state?.position.dy ?? 100,
      child: GestureDetector(
        onTapDown: (_) {
          if (!(state?.isFocused ?? false)) {
            wm.focusWindow(windowId);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: state?.size.width ?? 600,
          height: state?.size.height ?? 400,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.blueGrey),
            boxShadow: [
              if (state?.isFocused ?? false) const BoxShadow(blurRadius: 12, color: Colors.black26),
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                key: ValueKey('titlebar_$windowId'),
                onPanEnd: (_) => wm.focusWindow(windowId),
                onPanUpdate: (d) {
                  wm.moveWindow(windowId, d.delta);
                },
                child: _TitleBar(windowId: windowId, title: title, icon: windowIcon),
              ),
              Expanded(child: child),
            ],
          ),
        ),
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
            onPressed: () => ref.read(windowManagerProvider.notifier).minimizeWindow(windowId),
          ),
          IconButton(
            key: ValueKey('close_$windowId'),
            icon: const Icon(Icons.close),
            onPressed: () => ref.read(windowManagerProvider.notifier).closeWindow(windowId),
          ),
        ],
      ),
    );
  }
}
