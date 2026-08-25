import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWindow extends StatelessWidget {
  const ContactWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'Contact'),

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
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 11,
                          color: skin.iconMuted,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Nairobi, Kenya',
                          style:
                              TextStyle(fontSize: 11, color: skin.iconMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(height: 1, color: skin.divider),

          // Contact items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GET IN TOUCH',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: skin.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ContactRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'ngatiaelvisw@gmail.com',
                    url: 'mailto:ngatiaelvisw@gmail.com',
                  ),
                  _ContactRow(
                    icon: Icons.code,
                    label: 'GitHub',
                    value: 'github.com/ElNgatia',
                    url: 'https://github.com/ElNgatia',
                  ),
                  _ContactRow(
                    icon: Icons.alternate_email,
                    label: 'Twitter / X',
                    value: '@ngatiaelvis_',
                    url: 'https://www.x.com/ngatiaelvis_',
                  ),
                  _ContactRow(
                    icon: Icons.message_outlined,
                    label: 'Discord',
                    value: 'blindbandit_bmc',
                    url: 'https://discord.com/users/blindbandit_bmc',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: skin.cardHeaderBackground,
                      border: Border.all(color: skin.cardBorder),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "Open to collaborations, freelance projects, and exciting opportunities. Don't hesitate to reach out!",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: skin.headingColor,
                        height: 1.5,
                      ),
                    ),
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

class _ContactRow extends StatefulWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String value;
  final String url;

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: _open,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _hovered ? skin.hoverBackground : skin.cardBackground,
              border: Border.all(
                color: _hovered ? skin.accent : skin.cardBorder,
              ),
              borderRadius: BorderRadius.circular(3),
              boxShadow: skin.cardShadow,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _hovered ? skin.accent : skin.avatarBackground,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: skin.textMuted,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        widget.value,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _hovered ? skin.accent : skin.headingColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: _hovered ? skin.accent : skin.iconDisabled,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
