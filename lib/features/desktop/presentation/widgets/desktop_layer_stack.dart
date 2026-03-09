import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/desktop/presentation/views/about_me_window.dart';
import 'package:portfolio/features/desktop/presentation/views/experience_window.dart';
import 'package:portfolio/features/desktop/presentation/views/projects_window.dart';
import 'package:portfolio/features/desktop/presentation/widgets/window_frame.dart';
import 'package:portfolio/features/taskbar/presentation/widgets/taskbar.dart';

class DesktopLayerStack extends ConsumerWidget {
  const DesktopLayerStack({super.key});
  Widget _buildWindowContentById(WindowEntity window) {
    // Map window.id values to the corresponding content widgets.
    // '123' is the About Me desktop icon id from desktop_icons_provider.
    switch (window.id) {
      case '123':
        return const AboutMeWindow();
      case '456':
        return const ProjectsWindow();
      case '789':
        return const ExperienceWindow();
      default:
        return Center(child: Text(window.title));
    }
  }

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
            windowIcon: window.icon,
            child: _buildWindowContentById(window),
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
