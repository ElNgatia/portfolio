// ...existing code...
import 'package:flutter/material.dart';

class AboutMeWindow extends StatelessWidget {
  const AboutMeWindow({super.key});

  Widget _paragraph(String text, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elvis Ngatia',
                        style:
                            Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Flutter Mobile Engineer',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // content paragraphs
            _paragraph(
              "Hey there! I’m Elvis Ngatia, a Flutter Mobile Engineer who enjoys turning ideas into smooth, beautiful, and reliable mobile experiences. I write code the same way I like my playlists—clean, well-organized, and with great flow. I specialize in building Android and iOS apps using Flutter, with a soft spot for Clean Architecture, Riverpod, and anything that makes codebases easier to understand and scale.",
              context,
            ),
            _paragraph(
              "I’m the kind of developer who gets genuinely excited by a tricky bug, an unclear API flow, or a complex UI challenge—because it means I get to sharpen my problem-solving skills and make something better than it was yesterday. Over time, I’ve worked on everything from sales automation tools to advanced multi-step forms, multilingual apps, custom performance dashboards, and even hardware integrations like Sunmi printers.",
              context,
            ),
            _paragraph(
              "I care a lot about writing maintainable code. Whether I'm improving readability, reducing technical debt, or refactoring legacy screens into something cleaner and more SOLID, I'm happiest when the architecture behind the scenes is as beautiful as the UI the user interacts with. I’ve also built translation validation tools, designed dynamic state-driven UIs, and worked with APIs that sometimes… have minds of their own.",
              context,
            ),
            _paragraph(
              "Outside of mobile engineering, I’m leveling up in backend and cloud development because I believe great developers understand both sides of the stack. I enjoy learning how things work behind the scenes, optimizing data flows, and exploring how modern architectures and AI can help build smarter, more intuitive apps.",
              context,
            ),
            _paragraph(
              "When I’m not coding, you’ll probably find me exploring new music, reimagining app ideas, reading about tech I might not need yet (but definitely want), or creating tools to automate parts of my workflow. I love building things that feel polished, purposeful, and fun to use.",
              context,
            ),
            const SizedBox(height: 8),
            Text(
              "If you're looking for a developer who cares about clean structure, good UI, performance, and long-term scalability—and can sprinkle a bit of personality into the process—I’d love to connect.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
