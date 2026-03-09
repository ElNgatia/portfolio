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
    name: 'Brown and Bliss',
    description:
        'A bespoke digital experience crafted for Brown and Bliss. Built with care and attention to detail.',
    tags: ['Flutter', 'Dart'],
  ),
  Project(
    name: 'Chrome Extension',
    description:
        'A Chrome browser extension published under developer name "El Ngatia". Currently under review on the Chrome Web Store.',
    tags: ['Chrome Extension', 'JavaScript'],
    isPending: true,
  ),
];
