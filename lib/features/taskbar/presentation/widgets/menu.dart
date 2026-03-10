import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
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
                        const size = Size(900, 600);
                        final screenSize = MediaQuery.of(context).size;
                        final position = Offset(
                          (screenSize.width - size.width) / 2,
                          (screenSize.height - size.height) / 2,
                        );
                        Navigator.of(context).pop();
                        ref
                            .read(windowManagerProvider.notifier)
                            .openWindow(
                              WindowEntity(
                                id: '901',
                                icon: const Icon(Icons.language),
                                title: 'Internet Explorer',
                                position: position,
                                size: size,
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
