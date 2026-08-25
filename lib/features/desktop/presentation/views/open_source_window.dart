import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/data/packages_data.dart';
import 'package:portfolio/features/desktop/domain/entity/pub_package.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:url_launcher/url_launcher.dart';

/// Open source window: maintained pub.dev packages with live links and
/// verified quality metrics.
class OpenSourceWindow extends StatelessWidget {
  const OpenSourceWindow({super.key});

  Future<void> _open(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'Open Source'),
          Container(height: 1, color: skin.divider),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'I also build and maintain reusable Dart and Flutter packages outside application-specific code — designing, packaging, documenting and maintaining libraries rather than only consuming them.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: skin.textSecondary,
                    ),
                  ),
                ),
                for (final package in pubPackages)
                  _PackageCard(
                    package: package,
                    onOpenLink: (url) => _open(url, context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({required this.package, required this.onOpenLink});

  final PubPackage package;
  final void Function(String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: skin.cardBackground,
        border: Border.all(color: skin.cardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: skin.cardHeaderBackground,
              border: Border(bottom: BorderSide(color: skin.divider)),
            ),
            child: Row(
              children: [
                Text(
                  package.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: skin.headingWeight,
                    color: skin.headingColor,
                  ),
                ),
                const Spacer(),
                if (!package.publishedOnPubDev)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: skin.violetBadge.background,
                      border: Border.all(color: skin.violetBadge.border),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'GitHub',
                      style: TextStyle(
                        fontSize: 10,
                        color: skin.violetBadge.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else ...[
                  if (package.latestVersion != null)
                    Text(
                      'v${package.latestVersion}',
                      style:
                          TextStyle(fontSize: 11, color: skin.textMuted),
                    ),
                  if (package.pubPoints != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: skin.successBadge.background,
                        border: Border.all(color: skin.successBadge.border),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '${package.pubPoints}/${package.maxPoints} pts',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: skin.successBadge.text,
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: skin.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _LinkChip(
                      label: package.publishedOnPubDev ? 'pub.dev' : 'GitHub',
                      icon: package.publishedOnPubDev
                          ? Icons.widgets_outlined
                          : Icons.code,
                      url: package.pubDevUrl,
                      onTap: onOpenLink,
                    ),
                    if (package.githubUrl != null &&
                        package.githubUrl != package.pubDevUrl) ...[
                      const SizedBox(width: 6),
                      _LinkChip(
                        label: 'GitHub',
                        icon: Icons.code,
                        url: package.githubUrl!,
                        onTap: onOpenLink,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  const _LinkChip({
    required this.label,
    required this.icon,
    required this.url,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String url;
  final void Function(String url) onTap;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [skin.buttonTop, skin.buttonBottom],
            ),
            border: Border.all(color: skin.buttonBorder),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: skin.textTertiary),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(fontSize: 11, color: skin.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
