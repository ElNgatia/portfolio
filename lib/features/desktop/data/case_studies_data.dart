import 'package:portfolio/features/desktop/domain/entity/case_study.dart';

const List<CaseStudy> caseStudies = [
  CaseStudy(
    slug: 'android-resource-exhaustion',
    title:
        'When parallel work became too much: fixing startup failures on constrained Android hardware',
    summary:
        'Diagnosed startup failures caused by excessive concurrent resource acquisition and reworked initialization to control concurrency instead of treating every startup task as independently safe to run in parallel.',
    context:
        'The application performs multiple startup tasks before users reach the main workflow. It runs on Android hardware with very different resource capabilities, from high-end devices to constrained handsets used by field teams.',
    problem:
        'A large number of operations were started concurrently during initialization. On constrained hardware this could exhaust available file descriptors and network resources, producing failures that behaved differently across devices and were difficult to reproduce.',
    investigation: [
      'A startup screen failed while loading data.',
      'The behavior was inconsistent across devices, which ruled out a simple logic error.',
      'Logs did not initially make the underlying problem obvious.',
      'The common startup path was compared against a previously observed resource-exhaustion pattern.',
      'The root cause was traced to unbounded concurrent work and resource acquisition.',
    ],
    decisions: [
      'Control concurrency at the point where resources are acquired, rather than adding retries that would mask the exhaustion.',
      'Treat device capability as part of the design space: the fix had to hold on low-resource hardware, not just flagship devices.',
    ],
    implementation: [
      'Reworked initialization so concurrent fan-out was replaced with controlled sequencing of resource-acquiring tasks.',
      'Kept genuinely independent work parallel where it did not contend for scarce system resources.',
    ],
    lesson:
        'Mobile performance is constrained by system resources such as file descriptors, sockets, memory and storage operations, not just CPU and frame rendering.',
    technologies: [
      'Flutter',
      'Dart',
      'Android',
      'HTTP / networking',
      'Resource management',
      'Debugging',
    ],
    evidence: [
      EvidenceBlock(
        type: EvidenceType.log,
        title: 'Failure signature observed in the wild',
        content: 'EMFILE\nToo many open files',
      ),
      EvidenceBlock(
        type: EvidenceType.code,
        title: 'Conceptual before — unbounded fan-out',
        content: "await Future.wait(tasks.map((task) => task()));",
      ),
      EvidenceBlock(
        type: EvidenceType.code,
        title: 'Conceptual after — controlled concurrency',
        content: 'for (final task in tasks) {\n  await task();\n}',
      ),
    ],
  ),
  CaseStudy(
    slug: 'legacy-sfa-modernization',
    title:
        'Modernizing a decade-old field-sales application without stopping production delivery',
    summary:
        'Modernized the architecture of a mature Sales Force Automation application while preserving offline workflows, backend compatibility and continuous production releases for field teams across Africa.',
    context:
        'A mature Sales Force Automation application contains long-lived business workflows and operational constraints. Field agents depend on it daily; existing users and workflows still need to function while the modernization work introduces a newer architecture.',
    problem:
        'The challenge was not simply replacing old code. The application needed modernization while preserving operational workflows — sales orders, route plans, timesheets, payments, printing, notifications — supporting offline usage, maintaining backend compatibility and continuing to ship production releases throughout.',
    investigation: [
      'Mapped existing customer workflows (sales orders, payments, printing, notifications) to identify what could not break during migration.',
      'Identified state-management complexity as the primary scaling bottleneck for feature delivery.',
      'Assessed local persistence and synchronization requirements for field users with unreliable connectivity.',
    ],
    decisions: [
      'Adopted Riverpod-based state management to make dependency injection predictable and feature delivery scalable across complex modules.',
      'Designed an offline-first data layer so field users could continue working without reliable connectivity and synchronize changes when connectivity returned.',
      'Introduced structured routing and modular persistence rather than a big-bang rewrite.',
    ],
    implementation: [
      'Migrated production modules incrementally, keeping legacy workflows functional alongside modernized ones.',
      'Automated mobile build and release workflows with GitHub Actions and self-hosted infrastructure.',
      'Integrated Firebase services (Crashlytics, Notifications, App Distribution) for reliability and fast feedback cycles.',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'Riverpod',
      'GoRouter',
      'Isar',
      'REST APIs',
      'Firebase',
      'GitHub Actions',
      'Docker',
    ],
  ),
  CaseStudy(
    slug: 'offline-first-architecture',
    title: "Designing a mobile app that still works when the network doesn't",
    summary:
        'Built around local persistence and synchronization so field workflows remain usable even when connectivity is unreliable.',
    context:
        'Field teams operate in environments where connectivity is intermittent at best. The product requirement was not "support offline" as a nice-to-have — the offline path had to be the primary path, with synchronization restoring consistency whenever connectivity allowed.',
    problem:
        'A cloud-first design would leave agents unable to record orders, payments or visits exactly when they are with customers. Reads and writes both had to work locally, with queued writes synchronizing safely once online.',
    investigation: [
      'Analyzed real connectivity patterns of field users to understand how long offline periods could last.',
      'Evaluated local persistence options against query patterns and sync needs.',
      'Identified failure modes: retries during flaky connections, duplicate submissions after reconnects, and eventual-consistency surprises in the UI.',
    ],
    decisions: [
      'Local reads served from an on-device database, never blocking on the network.',
      'Writes go to a durable queue first, then synchronize to the REST API.',
      'Retries with exponential backoff and duplicate prevention so reconnect storms do not corrupt data.',
      'UI communicates eventual consistency honestly instead of pretending everything is live.',
    ],
    implementation: [
      'Repository layer abstracting local database vs remote API behind one interface.',
      'Sync/queue layer handling ordering, retries, backoff and conflict handling where applicable.',
    ],
    lesson:
        'Offline-first is a product decision, not a database choice. The architecture diagram is simple; the edge cases — duplicates, conflicts, retries — are where the engineering lives.',
    technologies: ['Flutter', 'Dart', 'Drift/Isar', 'REST APIs', 'Synchronization'],
    evidence: [
      EvidenceBlock(
        type: EvidenceType.diagram,
        title: 'Offline-first architecture',
        content: '''
                    +----------------+
                    |   Flutter UI   |
                    +--------+-------+
                             |
                    +--------v-------+
                    |   Repository   |
                    +--------+-------+
                             |
                +------------+-------------+
                |                          |
       +--------v--------+        +--------v--------+
       |  Local database |        |  Sync / Queue   |
       +-----------------+        +--------+---------+
                                           |
                                  +--------v--------+
                                  |    REST API     |
                                  +-----------------+''',
      ),
    ],
  ),
  CaseStudy(
    slug: 'deployment-efficiency',
    title: 'Improving mobile deployment efficiency by 30%',
    summary:
        'Automated mobile build and release workflows, contributing to a verified 30% improvement in deployment efficiency.',
    context:
        'Mobile releases involved manual steps across build, signing, versioning and distribution. Each manual step added time and error risk, and releases slowed down as the team and module count grew.',
    problem:
        'Releases depended on tribal knowledge and repetitive manual work. Testing builds reached testers slowly, and every release carried the risk of human error in versioning or distribution.',
    investigation: [
      'Documented the real end-to-end release process and measured where time went.',
      'Identified the highest-friction steps: manual builds, version bumps and distribution to testers.',
    ],
    decisions: [
      'Automate the whole pipeline rather than scripting individual steps.',
      'Use self-hosted infrastructure for control over build performance and secrets.',
      'Integrate Firebase App Distribution so test builds reach testers automatically.',
    ],
    implementation: [
      'Built CI/CD pipelines around GitHub Actions with self-hosted runners and Docker.',
      'Automated builds, versioning and Play Store publishing paths.',
      'Set up Firebase App Distribution for automated delivery of test builds.',
    ],
    lesson:
        'Release automation pays for itself quickly: fewer manual errors, faster feedback cycles, and engineers who stop fearing release day.',
    technologies: [
      'GitHub Actions',
      'Docker',
      'Self-hosted runners',
      'Play Store publishing',
      'Firebase App Distribution',
    ],
  ),
];
