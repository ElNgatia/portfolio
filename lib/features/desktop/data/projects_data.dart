import 'package:portfolio/features/desktop/domain/entity/project.dart';

const List<Project> publishedProjects = [
  Project(
    name: 'Mpesa Fees',
    description:
        'A Flutter app that calculates M-Pesa transaction fees so you never have to do the mental math. Available on the Google Play Store.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.wrenix.mpesafees',
    githubUrl: 'https://github.com/ElNgatia/Mpesa-Fees',
    tags: ['Flutter', 'Dart', 'Android'],
  ),
  Project(
    name: 'Adventure Quest',
    description:
        'An Android app that suggests random activities to beat boredom by consuming the Bored API. Includes local data persistence using Drift.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.adventurequest.app',
    githubUrl: 'https://github.com/ElNgatia/adventure-quest',
    tags: ['Flutter', 'Dart', 'Android'],
  ),
  Project(
    name: 'Select With Search',
    description:
        'A Flutter package providing a customizable dropdown select widget with built-in search functionality. Supports single and multiple selection modes with efficient filtering.',
    githubUrl: 'https://github.com/ElNgatia/select_with_search',
    tags: ['Flutter', 'Dart', 'Package'],
  ),
  Project(
    name: 'SAT Localization Checker',
    description:
        'A CLI tool for Flutter projects that identifies non-localized strings in your codebase, generates ARB localization files, and detects duplicate translation keys. Built with Dart and Go.',
    githubUrl: 'https://github.com/ElNgatia/sat-localization-checker',
    tags: ['Dart', 'Go', 'CLI', 'Developer Tool'],
  ),
  Project(
    name: 'Olivia Portfolio',
    description:
        'A professional portfolio website built for Olivia Mukora, a Social Media Manager and Content Strategist based in Nairobi. Features automated deployment via GitHub Actions.',
    githubUrl: 'https://github.com/ElNgatia/olivia-portfolio',
    tags: ['React', 'JavaScript', 'Tailwind CSS', 'Web'],
  ),
  Project(
    name: 'Brown and Bliss',
    description:
        'A bespoke web experience crafted for Brown and Bliss. Built with care and attention to detail.',
    tags: ['Web'],
  ),
  Project(
    name: 'Chrome Extension',
    description:
        'A Chrome browser extension published under developer name "El Ngatia". Currently under review on the Chrome Web Store.',
    tags: ['Chrome Extension', 'JavaScript'],
    isPending: true,
  ),
];
