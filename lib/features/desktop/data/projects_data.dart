import 'package:portfolio/features/desktop/domain/entity/project.dart';

/// Products I've shipped — presented as products with users and outcomes,
/// not a screenshot gallery. Metrics must be verified against Play Console
/// or store listings before removing "[VERIFY]" placeholders.
const List<Project> publishedProjects = [
  Project(
    name: 'TUCHEZE',
    description:
        'A local-first multiplayer party game built around locally relevant charades content. First launch works fully offline from seeded content, with Supabase-backed remote content sync, AdMob monetization and one-time Remove-Ads in-app purchase.',
    githubUrl: 'https://github.com/ElNgatia/tucheze',
    role: 'Solo developer',
    tags: [
      'Flutter',
      'Riverpod',
      'Drift',
      'Supabase',
      'AdMob',
      'In-app purchases',
      'Android',
    ],
  ),
  Project(
    name: 'Mpesa Fees',
    description:
        'Calculates M-Pesa transaction fees so users never have to do the mental math on the most-used payment rail in Kenya. Published on the Google Play Store.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.wrenix.mpesafees',
    githubUrl: 'https://github.com/ElNgatia/Mpesa-Fees',
    role: 'Solo developer',
    tags: ['Flutter', 'Dart', 'Android'],
  ),
  Project(
    name: 'Adventure Quest',
    description:
        'Suggests random activities to beat boredom via the Bored API, with local persistence so saved activities survive restarts.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.adventurequest.app',
    githubUrl: 'https://github.com/ElNgatia/adventure-quest',
    role: 'Solo developer',
    tags: ['Flutter', 'Dart', 'Drift', 'Android'],
  ),
  Project(
    name: 'SAT Localization Checker',
    description:
        'A CLI tool that identifies non-localized strings in Flutter codebases, generates ARB localization files, and detects duplicate translation keys — automating localization QA that was previously manual.',
    githubUrl: 'https://github.com/ElNgatia/sat-localization-checker',
    tags: ['Dart', 'Go', 'CLI', 'Developer Tool'],
  ),
  Project(
    name: 'Learning Tracker',
    description:
        'A Chrome extension for tracking learning progress, published under "El Ngatia".',
    tags: ['Chrome Extension', 'JavaScript'],
    isPending: true,
  ),
];
