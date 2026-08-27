import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/views/about_me_window.dart';
import 'package:portfolio/features/desktop/presentation/views/browser_window.dart';
import 'package:portfolio/features/desktop/presentation/views/case_studies_window.dart';
import 'package:portfolio/features/desktop/presentation/views/contact_window.dart';
import 'package:portfolio/features/desktop/presentation/views/experience_window.dart';
import 'package:portfolio/features/desktop/presentation/views/media_player_window.dart';
import 'package:portfolio/features/desktop/presentation/views/open_source_window.dart';
import 'package:portfolio/features/desktop/presentation/views/projects_window.dart';
import 'package:portfolio/features/desktop/presentation/views/resume_window.dart';
import 'package:portfolio/features/settings/settings.dart';

/// Maps a window id to its content widget.
///
/// Shared by the desktop window frame and the mobile (Metro) app shell.
Widget windowContentFor(WindowEntity window) {
  // Ids mirror the desktop icon ids from desktop_icons_provider.
  switch (window.id) {
    case '012':
      return const ContactWindow();
    case '123':
      return const AboutMeWindow();
    case '456':
      return const ProjectsWindow();
    case '789':
      return const ExperienceWindow();
    case '678':
      return const SettingsWindow();
    case '345':
      return const ResumeWindow();
    case '901':
      return const BrowserWindow();
    case '234':
      return const CaseStudiesWindow();
    case '567':
      return const OpenSourceWindow();
    case '112':
      return const MediaPlayerWindow();
    default:
      return Center(child: Text(window.title));
  }
}
