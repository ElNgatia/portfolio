import 'package:portfolio/features/desktop/domain/entity/experience.dart';

const List<Experience> workExperience = [
  Experience(
    role: 'Flutter Mobile Engineer',
    company: 'Park Point',
    duration: 'Jan 2024 – Present',
    location: 'Nairobi, Kenya · On-site',
    employmentType: 'Full-time',
    isCurrent: true,
    description:
        'Building and maintaining production-grade Flutter applications with a focus on clean architecture, performance, and scalability.',
    highlights: [
      'Engineered a sales automation platform with multi-step form flows and dynamic state-driven UIs, reducing sales rep onboarding time significantly.',
      'Integrated Sunmi POS hardware (thermal printers) into mobile apps, enabling seamless in-app receipt printing for retail clients.',
      'Built multilingual apps with full locale support and a custom translation validation CLI tool (SAT Localization Checker) to streamline i18n quality assurance.',
      'Developed custom performance dashboards with real-time data visualisation and drill-down analytics.',
      'Led refactoring efforts to migrate legacy screens to Clean Architecture with Riverpod, improving testability and long-term maintainability.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'Riverpod',
      'Clean Architecture',
      'REST APIs',
      'Sunmi SDK',
      'i18n',
    ],
  ),
  Experience(
    role: 'Flutter Developer',
    company: 'Freelance',
    duration: 'Mar 2023 – Dec 2023',
    location: 'Remote',
    employmentType: 'Contract',
    isCurrent: false,
    description:
        'Delivered end-to-end mobile and web projects for clients, from initial scoping through design, development, and deployment.',
    highlights: [
      'Built Brown & Bliss — a bespoke web experience backed by Supabase, handling authentication, database design, and real-time features.',
      'Developed and published Mpesa Fees on the Google Play Store, a utility app for calculating M-Pesa transaction costs.',
      'Released Adventure Quest on the Play Store, a Flutter app with local data persistence using Drift.',
      'Crafted Olivia Portfolio — a React/Tailwind professional website with automated GitHub Actions deployment.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'React',
      'Supabase',
      'Firebase',
      'Tailwind CSS',
      'GitHub Actions',
    ],
  ),
  Experience(
    role: 'Junior Flutter Developer',
    company: 'Self-directed Learning & Open Source',
    duration: 'Aug 2021 – Feb 2023',
    location: 'Nairobi, Kenya',
    employmentType: 'Independent',
    isCurrent: false,
    description:
        'Deepened Flutter expertise through personal projects, open-source contributions, and community engagement.',
    highlights: [
      'Published timeago_plus on pub.dev — a maintained, dependency-free Dart package for human-friendly relative timestamps with full locale support.',
      'Published select_with_search — a Flutter package offering a customisable dropdown with built-in search for single and multi-select use cases.',
      'Completed technical assessments and built proof-of-concept apps exploring gRPC, local notifications, and hardware sensor integrations.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'pub.dev',
      'Open Source',
      'gRPC',
      'Local Notifications',
    ],
  ),
];
