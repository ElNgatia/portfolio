import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';

class AboutMeWindow extends StatelessWidget {
  const AboutMeWindow({super.key});

  Widget _paragraph(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: SkinPalette.of(context).textPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);

    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'About Me'),

          // Profile banner
          Container(
            width: double.infinity,
            color: skin.cardHeaderBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: skin.cardBorder, width: 2),
                    color: skin.avatarBackground,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elvis Ngatia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: skin.headingColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Flutter Mobile Engineer',
                      style: TextStyle(fontSize: 12, color: skin.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(height: 1, color: skin.divider),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: skin.headingWeight,
                      color: skin.headingColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _paragraph(
                    context,
                    "Hey there! I'm Elvis Ngatia, a Flutter Mobile Engineer who enjoys turning ideas into smooth, beautiful, and reliable mobile experiences. I write code the same way I like my playlists—clean, well-organized, and with great flow. I specialize in building Android and iOS apps using Flutter, with a soft spot for Clean Architecture, Riverpod, and anything that makes codebases easier to understand and scale.",
                  ),
                  _paragraph(
                    context,
                    "I'm the kind of developer who gets genuinely excited by a tricky bug, an unclear API flow, or a complex UI challenge—because it means I get to sharpen my problem-solving skills and make something better than it was yesterday. Over time, I've worked on everything from business automation tools to advanced multi-step forms, multilingual apps, custom performance dashboards, and a wide range of device and hardware integrations.",
                  ),
                  _paragraph(
                    context,
                    "I care a lot about writing maintainable code. Whether I'm improving readability, reducing technical debt, or refactoring legacy screens into something cleaner and more SOLID, I'm happiest when the architecture behind the scenes is as beautiful as the UI the user interacts with. I've also built translation validation tools, designed dynamic state-driven UIs, and worked with APIs that sometimes… have minds of their own.",
                  ),
                  _paragraph(
                    context,
                    "Outside of mobile engineering, I'm leveling up in backend and cloud development because I believe great developers understand both sides of the stack. I enjoy learning how things work behind the scenes, optimizing data flows, and exploring how modern architectures and AI can help build smarter, more intuitive apps.",
                  ),
                  _paragraph(
                    context,
                    "When I'm not coding, you'll probably find me exploring new music, reimagining app ideas, reading about tech I might not need yet (but definitely want), or creating tools to automate parts of my workflow. I love building things that feel polished, purposeful, and fun to use.",
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: skin.cardHeaderBackground,
                      border: Border.all(color: skin.cardBorder),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "If you're looking for a developer who cares about clean structure, good UI, performance, and long-term scalability—and can sprinkle a bit of personality into the process—I'd love to connect.",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: skin.headingColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Technical capabilities',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: skin.headingWeight,
                      color: skin.headingColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const WindowCapabilitiesCard(
                    category: 'Mobile',
                    items: ['Flutter', 'Dart', 'Android', 'iOS'],
                  ),
                  const SizedBox(height: 6),
                  const WindowCapabilitiesCard(
                    category: 'Architecture',
                    items: [
                      'Riverpod',
                      'Clean Architecture',
                      'Offline-first',
                      'Repository patterns',
                      'Synchronization',
                    ],
                  ),
                  const SizedBox(height: 6),
                  const WindowCapabilitiesCard(
                    category: 'Backend / Data',
                    items: [
                      'REST APIs',
                      'Dio',
                      'Isar',
                      'Drift',
                      'Hive CE',
                      'Supabase',
                      'Firebase',
                    ],
                  ),
                  const SizedBox(height: 6),
                  const WindowCapabilitiesCard(
                    category: 'Delivery',
                    items: [
                      'GitHub Actions',
                      'Docker',
                      'Self-hosted runners',
                      'Play Store publishing',
                      'Shorebird / OTA',
                    ],
                  ),
                  const SizedBox(height: 6),
                  const WindowCapabilitiesCard(
                    category: 'Production engineering',
                    items: [
                      'Crash debugging',
                      'Performance analysis',
                      'Resource management',
                      'Error handling',
                      'Observability',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
