import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';

final desktopIconsProvider = Provider<List<DesktopIcon>>(
  (ref) {
    return const [
      DesktopIcon(
        title: 'About Me',
        icon: Icon(Icons.person),
        appType: AppType.about,
        id: '123',
      ),
      DesktopIcon(
        title: 'Case Studies',
        icon: Icon(Icons.article),
        appType: AppType.caseStudies,
        id: '234',
      ),
      DesktopIcon(
        title: 'Open Source',
        icon: Icon(Icons.code),
        appType: AppType.openSource,
        id: '567',
      ),
      DesktopIcon(
        title: 'Products',
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
        icon: Icon(Icons.contact_mail),
        appType: AppType.contact,
        id: '012',
      ),
      DesktopIcon(
        title: 'Resume',
        icon: Icon(Icons.description),
        appType: AppType.resume,
        id: '345',
      ),
      DesktopIcon(
        title: 'Settings',
        icon: Icon(Icons.settings),
        appType: AppType.settings,
        id: '678',
      ),
      DesktopIcon(
        title: 'Browser',
        icon: Icon(Icons.language),
        appType: AppType.browser,
        id: '901',
      ),
    ];
  },
);
