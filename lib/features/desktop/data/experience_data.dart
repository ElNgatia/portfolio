import 'package:portfolio/features/desktop/domain/entity/experience.dart';

/// Experience entries follow an outcome-first formula:
/// outcome + engineering problem + action + evidence (+ technology).
const List<Experience> workExperience = [
  Experience(
    role: 'Mobile Engineer',
    company: 'Solutech Limited',
    duration: 'Jul 2024 – Present',
    location: 'Nairobi, Kenya',
    employmentType: 'Full-time',
    isCurrent: true,
    description:
        'Building and modernizing production mobile software for field operations, with responsibility spanning application architecture, offline workflows, reliability, release engineering and production debugging.',
    highlights: [
      'Modernized a legacy Sales Force Automation application toward a maintainable Flutter/Riverpod architecture while preserving production workflows for field teams across African markets.',
      'Designed offline-first data and synchronization workflows so field users could keep recording orders, payments and visits without reliable connectivity.',
      'Diagnosed startup failures on resource-constrained Android hardware caused by excessive concurrent resource acquisition, then reworked initialization to control concurrency.',
      'Improved mobile deployment efficiency by 30% within 4 months through release automation with GitHub Actions, self-hosted infrastructure and Firebase App Distribution.',
      'Supported production integrations including payments, notifications, printing, maps, analytics and device-specific workflows (e.g. Sunmi printers).',
      'Wrote unit and widget tests to keep refactoring safe during active feature delivery on a live product.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'Riverpod',
      'Isar',
      'Offline-first',
      'Firebase',
      'CI/CD',
      'GitHub Actions',
      'Production debugging',
    ],
    repositories: [
      // Public Solutech-Limited repos; commit counts verified via the
      // GitHub contributors API on 2026-08-25.
      WorkRepository(
        name: 'solutech-sat-360',
        url: 'https://github.com/Solutech-Limited/solutech-sat-360',
        description:
            'Cross-platform Solutech SAT with clean architecture and best practices.',
        commits: 1394,
      ),
      WorkRepository(
        name: 'solutech-sat',
        url: 'https://github.com/Solutech-Limited/solutech-sat',
        description: 'Sales Automation Tool used by field teams.',
        commits: 589,
      ),
      WorkRepository(
        name: 'solutech-sat-admin',
        url: 'https://github.com/Solutech-Limited/solutech-sat-admin',
        description: 'Admin companion app for the SAT platform.',
        commits: 59,
      ),
      WorkRepository(
        name: 'fleet-tv-app',
        url: 'https://github.com/Solutech-Limited/fleet-tv-app',
        description: 'Fleet monitoring dashboard for TV displays.',
        commits: 3,
      ),
      WorkRepository(
        name: 'kazitime',
        url: 'https://github.com/Solutech-Limited/kazitime',
        description: 'Time-tracking product.',
        commits: 4,
      ),
      WorkRepository(
        name: 'askeva-mobile',
        url: 'https://github.com/Solutech-Limited/askeva-mobile',
        description:
            "AskEVA — Solutech's conversational AI analytics assistant (Flutter).",
        commits: 1,
      ),
    ],
  ),
  Experience(
    role: 'Mobile Engineer',
    company: 'Real Biz Digital',
    companyUrl: null,
    duration: 'Jan 2024 – Jul 2024',
    location: 'Nairobi, Kenya',
    employmentType: 'Full-time',
    isCurrent: false,
    description:
        'Led mobile development of Grow with Biz — a self-improvement application whose six modules (fitness tracking, book reading, finance management, networking events, workout planning, scheduling) all needed consistent goal-tracking and offline progress.',
    highlights: [
      'Led end-to-end mobile development of Grow with Biz across six integrated modules, designing goal-setting, progress tracking and accomplishments flows users rely on daily.',
      'Migrated the app\'s persistence to Drift ORM so progress tracking worked reliably offline without an internet connection.',
      'Collaborated with UI/UX designers to turn multi-module requirements into an intuitive, engaging interface.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'Provider',
      'Drift ORM',
      'Offline storage',
      'UI/UX collaboration',
    ],
  ),
  Experience(
    role: 'Web Developer',
    company: '12th Studio',
    duration: 'Mar 2024 – Jul 2024',
    location: 'Remote',
    employmentType: 'Part-time',
    isCurrent: false,
    description:
        'Shipped the 12th Studio portfolio website from conception to deployment, owning performance and responsiveness end to end.',
    highlights: [
      'Launched a dynamic portfolio website from conception to deployment, including domain registration and professional online presence setup.',
      'Improved website performance to above 90% Lighthouse score through targeted optimization.',
      'Implemented responsive design ensuring seamless experience across desktop and mobile devices.',
    ],
    skills: [
      'React',
      'JavaScript',
      'Responsive Design',
      'GitHub Actions',
      'Web Performance',
    ],
  ),
  Experience(
    role: 'Mobile Developer',
    company: 'Song Lib',
    duration: 'Apr 2023 – Jul 2023',
    location: 'Remote',
    employmentType: 'Contract',
    isCurrent: false,
    description:
        'Improved performance and maintainability of Song Lib, an app providing worship hymn books in various Kenyan languages.',
    highlights: [
      'Improved widget performance throughout the app for smoother rendering on low-end devices.',
      'Refactored the codebase for readability and added documentation that reduced developer onboarding time.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'Performance Optimisation',
      'Code Documentation',
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
        'Delivered end-to-end mobile and web products for clients — from scoping through design, development and deployment — including two apps published to the Play Store.',
    highlights: [
      'Built Brown & Bliss, a bespoke web experience backed by Supabase covering authentication, database design and real-time features.',
      'Developed and published Mpesa Fees on the Google Play Store, a utility app for calculating M-Pesa transaction costs.',
      'Released Adventure Quest on the Play Store with local data persistence using Drift.',
      'Crafted Olivia Portfolio, a React/Tailwind website with automated GitHub Actions deployment.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'React',
      'Supabase',
      'Firebase',
      'Tailwind CSS',
      'GitHub Actions',
      'Play Store publishing',
    ],
  ),
  Experience(
    role: 'Flutter Developer',
    company: 'Self-directed Learning & Open Source',
    duration: 'Aug 2021 – Feb 2023',
    location: 'Nairobi, Kenya',
    employmentType: 'Independent',
    isCurrent: false,
    description:
        'Built and published reusable Dart/Flutter packages as public evidence of library-grade engineering, alongside deepening Flutter expertise through personal projects and community engagement.',
    highlights: [
      'Published and maintained timeago_plus on pub.dev — a dependency-light Dart package for human-friendly relative timestamps with full locale support (160/160 pub points).',
      'Published timeago_plus_flutter, reactive widgets built around timeago_plus for relative-time displays.',
      'Built select_with_search, a customizable dropdown-with-search widget supporting single and multi-select modes.',
      'Completed technical assessments and built proof-of-concept apps exploring gRPC, local notifications and hardware sensor integrations.',
    ],
    skills: [
      'Flutter',
      'Dart',
      'pub.dev publishing',
      'Open Source',
      'gRPC',
      'Local Notifications',
    ],
  ),
];
