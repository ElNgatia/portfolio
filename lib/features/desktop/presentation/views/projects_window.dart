import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/projects_data.dart';
import 'package:portfolio/features/desktop/domain/entity/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsWindow extends StatelessWidget {
  const ProjectsWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Published Projects',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ProjectCard(
                project: publishedProjects[index],
              ),
              childCount: publishedProjects.length,
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
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
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (project.isPending)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Text(
                      'Pending review',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: theme.textTheme.bodyMedium,
            ),
            if (project.tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: project.tags
                    .map(
                      (tag) => Chip(
                        label: Text(
                          tag,
                          style: theme.textTheme.bodySmall,
                        ),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
            if (_hasLinks(project)) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
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
                    _PendingLinkChip(label: 'Chrome Store — Pending review'),
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

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  final String label;
  final IconData icon;
  final String url;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $label link.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _open(context),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        textStyle: Theme.of(context).textTheme.bodySmall,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class _PendingLinkChip extends StatelessWidget {
  const _PendingLinkChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: null,
      icon: const Icon(Icons.extension_outlined, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        textStyle: Theme.of(context).textTheme.bodySmall,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
