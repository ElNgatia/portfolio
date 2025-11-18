import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
                      onTap: () {},
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
