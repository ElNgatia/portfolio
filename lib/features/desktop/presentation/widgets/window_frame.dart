import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

class WindowFrame extends ConsumerWidget {
  final String windowId;
  final String title;
  final Widget child;

  const WindowFrame({
    super.key,
    required this.windowId,
    required this.title,
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
        onPanUpdate: (d) => wm.moveWindow(windowId, d.delta),
        onTapDown: (_) => wm.focusWindow(windowId),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: state?.size.width ?? 600,
          height: state?.size.height ?? 400,
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
              // _TitleBar(windowId: windowId, title: title),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

