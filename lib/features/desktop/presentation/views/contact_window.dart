import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7Blue = Color(0xFF0078D7);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

class ContactWindow extends StatelessWidget {
  const ContactWindow({super.key});

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
              'Contact',
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
                    const SizedBox(height: 3),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 11,
                          color: Color(0xFF666666),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Nairobi, Kenya',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(height: 1, color: _kWin7CardBorder),

          // Contact items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GET IN TOUCH',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6A7A8A),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _ContactRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'ngatiaelvisw@gmail.com',
                    url: 'mailto:ngatiaelvisw@gmail.com',
                  ),
                  const _ContactRow(
                    icon: Icons.code,
                    label: 'GitHub',
                    value: 'github.com/ElNgatia',
                    url: 'https://github.com/ElNgatia',
                  ),
                  const _ContactRow(
                    icon: Icons.alternate_email,
                    label: 'Twitter / X',
                    value: '@ngatiaelvis_',
                    url: 'https://www.x.com/ngatiaelvis_',
                  ),
                  const _ContactRow(
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
                      color: _kWin7SectionBg,
                      border: Border.all(color: _kWin7CardBorder),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      "Open to collaborations, freelance projects, and exciting opportunities. Don't hesitate to reach out!",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A246A),
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
              color: _hovered ? const Color(0xFFE5F3FF) : Colors.white,
              border: Border.all(
                color: _hovered
                    ? const Color(0xFF3C9BE0)
                    : _kWin7CardBorder,
              ),
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _hovered ? _kWin7Blue : const Color(0xFF2567A5),
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
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        widget.value,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _hovered
                              ? _kWin7Blue
                              : const Color(0xFF0A246A),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: _hovered
                      ? _kWin7Blue
                      : const Color(0xFFBBBBBB),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
