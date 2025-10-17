import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/desktop/presentation/widgets/window_frame.dart';
import 'package:portfolio/features/taskbar/taskbar.dart';

class DesktopLayerStack extends ConsumerWidget {
  const DesktopLayerStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openWindows = ref
        .watch(windowManagerProvider)
        .entries
        .where((entry) => entry.value.isOpen && !entry.value.isMinimized)
        .map((entry) => entry.value)
        .toList();
    // final isStartMenuVisible = ref.watch(startMenuVisibilityProvider);

    return Stack(
      children: [
        // Windows
        for (final window in openWindows)
          WindowFrame(
            windowId: window.id,
            title: window.title,
            child: Column(),
          ),

        // Start Menu overlay
        // if (isStartMenuVisible)
        //   const StartMenuWidget(),

        // Taskbar (always on top)
        const Align(
          alignment: Alignment.bottomCenter,
          child: TaskBar(),
        ),
      ],
    );
  }
}
