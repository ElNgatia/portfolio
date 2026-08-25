import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/data/projects_data.dart';
import 'package:portfolio/features/desktop/domain/entity/project.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsWindow extends StatelessWidget {
  const ProjectsWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: "Products I've shipped"),
          Container(height: 1, color: skin.divider),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: publishedProjects.length,
              itemBuilder: (context, index) =>
                  _ProjectCard(project: publishedProjects[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: skin.cardBackground,
        border: Border.all(color: skin.cardBorder),
        borderRadius: BorderRadius.circular(3),
        boxShadow: skin.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: skin.cardHeaderBackground,
              border: Border(bottom: BorderSide(color: skin.divider)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: skin.headingWeight,
                      color: skin.headingColor,
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
                      color: skin.warningBadge.background,
                      border: Border.all(color: skin.warningBadge.border),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'Pending review',
                      style: TextStyle(
                        fontSize: 10,
                        color: skin.warningBadge.text,
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
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: skin.textPrimary,
                  ),
                ),
                if (project.role != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Role: ${project.role}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: skin.textMuted,
                    ),
                  ),
                ],
                if (project.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    children: project.tags
                        .map((tag) => _ProjectTag(label: tag))
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
                        _LinkButton(
                          label: 'Website',
                          icon: Icons.language_outlined,
                          url: project.websiteUrl!,
                        ),
                      if (project.pubDevUrl != null)
                        _LinkButton(
                          label: 'pub.dev',
                          icon: Icons.widgets_outlined,
                          url: project.pubDevUrl!,
                        ),
                      if (project.playStoreUrl != null)
                        _LinkButton(
                          label: 'Play Store',
                          icon: Icons.shop_outlined,
                          url: project.playStoreUrl!,
                        ),
                      if (project.chromeStoreUrl != null)
                        _LinkButton(
                          label: 'Chrome Store',
                          icon: Icons.extension_outlined,
                          url: project.chromeStoreUrl!,
                        ),
                      if (project.isPending && project.chromeStoreUrl == null)
                        const _DisabledButton(
                          label: 'Chrome Store — Pending',
                          icon: Icons.extension_outlined,
                        ),
                      if (project.githubUrl != null)
                        _LinkButton(
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

class _ProjectTag extends StatelessWidget {
  const _ProjectTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: skin.chipBackground,
        border: Border.all(color: skin.chipBorder),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: skin.chipText),
      ),
    );
  }
}

class _LinkButton extends StatefulWidget {
  const _LinkButton({
    required this.label,
    required this.icon,
    required this.url,
  });
  final String label;
  final IconData icon;
  final String url;

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
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
    final skin = SkinPalette.of(context);
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
                  ? [skin.hoverBackground, skin.hoverBackground]
                  : [skin.buttonTop, skin.buttonBottom],
            ),
            border: Border.all(
              color: _hovered ? skin.accent : skin.buttonBorder,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 12,
                color: _hovered ? skin.accent : skin.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 11,
                  color:
                      _hovered ? skin.accent : skin.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisabledButton extends StatelessWidget {
  const _DisabledButton({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: skin.buttonTop,
        border: Border.all(color: skin.iconDisabled),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: skin.iconDisabled),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: skin.iconDisabled),
          ),
        ],
      ),
    );
  }
}
