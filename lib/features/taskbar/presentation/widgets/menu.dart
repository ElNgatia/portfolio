import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

class StartMenu extends ConsumerWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 500,
      height: 600,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    StartMenuListTile(
                      title: 'Projects',
                      icon: Icon(Icons.construction),
                      onTap: () {},
                    ),
                    StartMenuListTile(
                      title: 'Browser',
                      icon: Icon(Icons.language),
                      onTap: () {
                        final screenSize = MediaQuery.of(context).size;
                        final isMobile =
                            screenSize.width < kMobileBreakpoint;

                        // Clamp browser window to fit the viewport.
                        final windowWidth =
                            math.min(900.0, screenSize.width);
                        final windowHeight = math.min(
                          600.0,
                          screenSize.height - kTaskbarHeight,
                        );
                        final windowSize =
                            Size(windowWidth, windowHeight);
                        final center = screenSize.center(Offset.zero) -
                            Offset(
                              windowSize.width / 2,
                              windowSize.height / 2,
                            );

                        Navigator.of(context).pop();
                        ref
                            .read(windowManagerProvider.notifier)
                            .openWindow(
                              WindowEntity(
                                id: '901',
                                icon: const Icon(Icons.language),
                                title: 'Internet Explorer',
                                position:
                                    isMobile ? Offset.zero : center,
                                size: isMobile
                                    ? Size(
                                        screenSize.width,
                                        screenSize.height -
                                            kTaskbarHeight,
                                      )
                                    : windowSize,
                                isMaximized: isMobile,
                                preMaximizePosition:
                                    isMobile ? center : null,
                                preMaximizeSize:
                                    isMobile ? windowSize : null,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    StartMenuListTile(
                      title: 'Settings',
                      icon: const Icon(Icons.settings),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StartMenuListTile extends StatelessWidget {
  const StartMenuListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }
}
