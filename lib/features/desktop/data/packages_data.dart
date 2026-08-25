import 'package:portfolio/features/desktop/domain/entity/pub_package.dart';

/// Live pub.dev metrics last verified 2026-08-25 via the pub.dev API.
const List<PubPackage> pubPackages = [
  PubPackage(
    name: 'timeago_plus',
    description:
        'Maintained Dart package for converting timestamps into human-readable relative time (e.g. "15 minutes ago"), with full locale support and no heavyweight dependencies.',
    ecosystem: 'Dart',
    pubDevUrl: 'https://pub.dev/packages/timeago_plus',
    githubUrl: 'https://github.com/ElNgatia/timeago_plus',
    latestVersion: '1.4.0',
    pubPoints: 160,
    maxPoints: 160,
  ),
  PubPackage(
    name: 'timeago_plus_flutter',
    description:
        'Flutter widgets built around timeago_plus for reactive relative-time displays.',
    ecosystem: 'Flutter',
    pubDevUrl: 'https://pub.dev/packages/timeago_plus_flutter',
    githubUrl: 'https://github.com/ElNgatia/timeago_plus',
    latestVersion: '1.1.0',
    pubPoints: 150,
    maxPoints: 160,
  ),
  PubPackage(
    name: 'select_with_search',
    description:
        'A customizable dropdown select widget with built-in search, supporting single and multiple selection modes with efficient filtering.',
    ecosystem: 'Flutter',
    pubDevUrl: 'https://github.com/ElNgatia/select_with_search',
    githubUrl: 'https://github.com/ElNgatia/select_with_search',
    publishedOnPubDev: false,
  ),
];
