// ...existing code...
import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

class AboutMeWindow extends StatelessWidget {
  const AboutMeWindow({super.key});

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          height: 1.5,
          color: Color(0xFF1A1A1A),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          // Win7-style section header
          Container(
            width: double.infinity,
            color: _kWin7DarkHeader,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Text(
              'About Me',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Profile banner
          Container(
            width: double.infinity,
            color: _kWin7SectionBg,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _kWin7CardBorder, width: 2),
                    color: const Color(0xFF2567A5),
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
                    const Text(
                      'Elvis Ngatia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A246A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Flutter Mobile Engineer',
                      style: TextStyle(fontSize: 12, color: Color(0xFF555555)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(height: 1, color: _kWin7CardBorder),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kWin7DarkHeader,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _paragraph(
                    "Hey there! I'm Elvis Ngatia, a Flutter Mobile Engineer who enjoys turning ideas into smooth, beautiful, and reliable mobile experiences. I write code the same way I like my playlists—clean, well-organized, and with great flow. I specialize in building Android and iOS apps using Flutter, with a soft spot for Clean Architecture, Riverpod, and anything that makes codebases easier to understand and scale.",
                  ),
                  _paragraph(
                    "I'm the kind of developer who gets genuinely excited by a tricky bug, an unclear API flow, or a complex UI challenge—because it means I get to sharpen my problem-solving skills and make something better than it was yesterday. Over time, I've worked on everything from sales automation tools to advanced multi-step forms, multilingual apps, custom performance dashboards, and even hardware integrations like Sunmi printers.",
                  ),
                  _paragraph(
                    "I care a lot about writing maintainable code. Whether I'm improving readability, reducing technical debt, or refactoring legacy screens into something cleaner and more SOLID, I'm happiest when the architecture behind the scenes is as beautiful as the UI the user interacts with. I've also built translation validation tools, designed dynamic state-driven UIs, and worked with APIs that sometimes… have minds of their own.",
                  ),
                  _paragraph(
                    "Outside of mobile engineering, I'm leveling up in backend and cloud development because I believe great developers understand both sides of the stack. I enjoy learning how things work behind the scenes, optimizing data flows, and exploring how modern architectures and AI can help build smarter, more intuitive apps.",
                  ),
                  _paragraph(
                    "When I'm not coding, you'll probably find me exploring new music, reimagining app ideas, reading about tech I might not need yet (but definitely want), or creating tools to automate parts of my workflow. I love building things that feel polished, purposeful, and fun to use.",
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _kWin7SectionBg,
                      border: Border.all(color: _kWin7CardBorder),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      "If you're looking for a developer who cares about clean structure, good UI, performance, and long-term scalability—and can sprinkle a bit of personality into the process—I'd love to connect.",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A246A),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Technical capabilities',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kWin7DarkHeader,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Win7CapabilitiesCard(
                    category: 'Mobile',
                    items: ['Flutter', 'Dart', 'Android', 'iOS'],
                  ),
                  const SizedBox(height: 6),
                  const Win7CapabilitiesCard(
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
                  const Win7CapabilitiesCard(
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
                  const Win7CapabilitiesCard(
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
                  const Win7CapabilitiesCard(
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
