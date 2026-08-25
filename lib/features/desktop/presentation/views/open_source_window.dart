import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/packages_data.dart';
import 'package:portfolio/features/desktop/domain/entity/pub_package.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:url_launcher/url_launcher.dart';

// Windows 7 Aero palette
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

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
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const Win7SectionHeader(title: 'Open Source'),
          Container(height: 1, color: _kWin7CardBorder),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'I also build and maintain reusable Dart and Flutter packages outside application-specific code — designing, packaging, documenting and maintaining libraries rather than only consuming them.',
                    style: TextStyle(fontSize: 12.5, height: 1.5, color: Color(0xFF333333)),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kWin7CardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: const BoxDecoration(
              color: _kWin7SectionBg,
              border: Border(bottom: BorderSide(color: _kWin7CardBorder)),
            ),
            child: Row(
              children: [
                Text(
                  package.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A246A),
                  ),
                ),
                const Spacer(),
                if (!package.publishedOnPubDev)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E5F5),
                      border: Border.all(color: const Color(0xFFBA68C8)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'GitHub',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6A1B9A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else ...[
                  if (package.latestVersion != null)
                    Text(
                      'v${package.latestVersion}',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF666666)),
                    ),
                  if (package.pubPoints != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        border: Border.all(color: const Color(0xFF66BB6A)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '${package.pubPoints}/${package.maxPoints} pts',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
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
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Color(0xFF1A1A1A),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF5F5F5), Color(0xFFDCDCDC)],
            ),
            border: Border.all(color: const Color(0xFFADADAD)),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: const Color(0xFF444444)),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF1A1A1A))),
            ],
          ),
        ),
      ),
    );
  }
}
