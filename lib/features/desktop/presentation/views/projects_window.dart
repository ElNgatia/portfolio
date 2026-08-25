import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/projects_data.dart';
import 'package:portfolio/features/desktop/domain/entity/project.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:url_launcher/url_launcher.dart';

// Windows 7 Aero palette
const _kWin7Blue = Color(0xFF0078D7);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);
const _kWin7TagBg = Color(0xFFF0F4F8);
const _kWin7TagBorder = Color(0xFF9BB8D0);

class ProjectsWindow extends StatelessWidget {
  const ProjectsWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const Win7SectionHeader(title: "Products I've shipped"),
          Container(height: 1, color: _kWin7CardBorder),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: publishedProjects.length,
              itemBuilder: (context, index) =>
                  _Win7ProjectCard(project: publishedProjects[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Win7ProjectCard extends StatelessWidget {
  const _Win7ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kWin7CardBorder),
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: const BoxDecoration(
              color: _kWin7SectionBg,
              border: Border(bottom: BorderSide(color: _kWin7CardBorder)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A246A),
                    ),
                  ),
                ),
                if (project.isPending)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      border: Border.all(color: const Color(0xFFFFB74D)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'Pending review',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFE65100),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                if (project.role != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Role: ${project.role}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
                if (project.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    children: project.tags
                        .map((tag) => _Win7Tag(label: tag))
                        .toList(),
                  ),
                ],
                if (_hasLinks(project)) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      if (project.websiteUrl != null)
                        _Win7LinkButton(
                          label: 'Website',
                          icon: Icons.language_outlined,
                          url: project.websiteUrl!,
                        ),
                      if (project.pubDevUrl != null)
                        _Win7LinkButton(
                          label: 'pub.dev',
                          icon: Icons.widgets_outlined,
                          url: project.pubDevUrl!,
                        ),
                      if (project.playStoreUrl != null)
                        _Win7LinkButton(
                          label: 'Play Store',
                          icon: Icons.shop_outlined,
                          url: project.playStoreUrl!,
                        ),
                      if (project.chromeStoreUrl != null)
                        _Win7LinkButton(
                          label: 'Chrome Store',
                          icon: Icons.extension_outlined,
                          url: project.chromeStoreUrl!,
                        ),
                      if (project.isPending && project.chromeStoreUrl == null)
                        _Win7DisabledButton(
                          label: 'Chrome Store — Pending',
                          icon: Icons.extension_outlined,
                        ),
                      if (project.githubUrl != null)
                        _Win7LinkButton(
                          label: 'GitHub',
                          icon: Icons.code,
                          url: project.githubUrl!,
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _hasLinks(Project project) =>
      project.websiteUrl != null ||
      project.pubDevUrl != null ||
      project.playStoreUrl != null ||
      project.chromeStoreUrl != null ||
      (project.isPending && project.chromeStoreUrl == null) ||
      project.githubUrl != null;
}

class _Win7Tag extends StatelessWidget {
  const _Win7Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: _kWin7TagBg,
        border: Border.all(color: _kWin7TagBorder),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: Color(0xFF2567A5)),
      ),
    );
  }
}

class _Win7LinkButton extends StatefulWidget {
  const _Win7LinkButton({
    required this.label,
    required this.icon,
    required this.url,
  });
  final String label;
  final IconData icon;
  final String url;

  @override
  State<_Win7LinkButton> createState() => _Win7LinkButtonState();
}

class _Win7LinkButtonState extends State<_Win7LinkButton> {
  bool _hovered = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${widget.label} link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _open,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _hovered
                  ? [const Color(0xFFE5F3FF), const Color(0xFFCCE4FF)]
                  : [const Color(0xFFF5F5F5), const Color(0xFFDCDCDC)],
            ),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF3C9BE0)
                  : const Color(0xFFADADAD),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 12,
                color: _hovered ? _kWin7Blue : const Color(0xFF444444),
              ),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 11,
                  color: _hovered ? _kWin7Blue : const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Win7DisabledButton extends StatelessWidget {
  const _Win7DisabledButton({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFAAAAAA)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}
