import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';

final desktopIconsProvider = Provider<List<DesktopIcon>>((ref) {
  return const [
    DesktopIcon(
      title: 'About Me',
      icon: 'assets/images/windows-7.jpg',
      appType: AppType.about,
      id: '123',
    ),
    DesktopIcon(
      title: 'Projects',
      icon: 'assets/images/windows-7.jpg',
      appType: AppType.projects,
      id: '456',
    ),
    DesktopIcon(
      title: 'Experience',
      icon: 'assets/images/windows-7.jpg',
      appType: AppType.experience,
      id: '789',
    ),
    DesktopIcon(
      title: 'Contact',
      icon: 'assets/images/windows-7.jpg',
      appType: AppType.contact,
      id: '012',
    ),
    DesktopIcon(
      title: 'Resume',
      icon: 'assets/images/windows-7.jpg',
      appType: AppType.resume,
      id: '345',
    ),
  ];
});
