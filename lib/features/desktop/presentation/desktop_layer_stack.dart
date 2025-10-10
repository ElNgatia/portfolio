import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopLayerStack extends ConsumerWidget {
  const DesktopLayerStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final openWindows = ref.watch(windowManagerProvider);
    // final isStartMenuVisible = ref.watch(startMenuVisibilityProvider);

    return Stack(
      children: [
        // Windows
        // for (final window in openWindows)
          Positioned(
            // left: window.position.dx,
            // top: window.position.dy,

            child: Container(),
            // child: WindowFrame(window: window),
          ),

        // Start Menu overlay
        // if (isStartMenuVisible)
          // const StartMenuWidget(),

        // Taskbar (always on top)
        // const Align(
        //   alignment: Alignment.bottomCenter,
        //   child: TaskbarWidget(),
        // ),
      ],
    );
  }
}
