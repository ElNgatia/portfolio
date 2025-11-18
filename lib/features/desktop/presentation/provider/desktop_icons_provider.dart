import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';

final desktopIconsProvider = Provider<List<DesktopIcon>>((ref) {
  return const [
    DesktopIcon(
      title: 'About Me',
      icon: Icon(Icons.person),
      appType: AppType.about,
      id: '123',
    ),
    DesktopIcon(
      title: 'Projects',
      icon: Icon(Icons.construction),
      appType: AppType.projects,
      id: '456',
    ),
    DesktopIcon(
      title: 'Experience',
      icon: Icon(Icons.work),
      appType: AppType.experience,
      id: '789',
    ),
    DesktopIcon(
      title: 'Contact',
      icon:Icon(Icons.contact_mail),
      appType: AppType.contact,
      id: '012',
    ),
    DesktopIcon(
      title: 'Resume',
      icon: Icon(Icons.description),
      appType: AppType.resume,
      id: '345',
    ),
  ];
});
