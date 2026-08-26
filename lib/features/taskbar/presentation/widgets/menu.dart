import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/domain/entity/desktop_icon.dart';
import 'package:portfolio/features/desktop/presentation/provider/desktop_icons_provider.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/taskbar/presentation/provider/power_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Windows 7-style start menu: searchable program list on the left,
/// user rail with quick links and a shut-down action on the right.
class StartMenu extends ConsumerStatefulWidget {
  const StartMenu({super.key});

  @override
  ConsumerState<StartMenu> createState() => _StartMenuState();
}

class _StartMenuState extends ConsumerState<StartMenu> {
  String _query = '';

  void _openApp(DesktopIcon icon) {
    Navigator.of(context).pop();
    ref
        .read(windowManagerProvider.notifier)
        .openApp(icon, MediaQuery.sizeOf(context));
  }

  Future<void> _openExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    if (mounted) Navigator.of(context).pop();
  }

  void _sleep() {
    Navigator.of(context).pop();
    ref.read(powerProvider.notifier).sleep();
  }

  void _shutDown() {
    Navigator.of(context).pop();
    final wm = ref.read(windowManagerProvider.notifier);
    for (final id in ref.read(windowManagerProvider).keys.toList()) {
      wm.closeWindow(id);
    }
    ref.read(powerProvider.notifier).shutDown();
  }

  bool _isSystemApp(DesktopIcon icon) =>
      icon.appType == AppType.settings || icon.appType == AppType.browser;

  bool _matches(DesktopIcon icon, String query) =>
      query.isEmpty || icon.title.toLowerCase().contains(query);

  @override
  Widget build(BuildContext context) {
    final icons = ref.watch(desktopIconsProvider);
    final query = _query.trim().toLowerCase();
    final mainApps = icons
        .where((icon) => !_isSystemApp(icon) && _matches(icon, query))
        .toList();
    final systemApps = icons
        .where((icon) => _isSystemApp(icon) && _matches(icon, query))
        .toList();

    return Container(
      width: 520,
      height: 560,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8FBFE), Color(0xFFE9F1F9)],
        ),
        border: Border.all(color: const Color(0xFFA6C4DC)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _ProgramList(
              list: mainApps,
              systemApps: systemApps,
              onQueryChanged: (value) => setState(() => _query = value),
              onOpenApp: _openApp,
            ),
          ),
          _UserRail(
            name: 'Elvis Ngatia',
            role: 'Mobile Engineer',
            onGitHub: () => _openExternal('https://github.com/ElNgatia'),
            onEmail: () => _openExternal('mailto:ngatiaelvisw@gmail.com'),
            onSleep: _sleep,
            onShutDown: _shutDown,
          ),
        ],
      ),
    );
  }
}

class _ProgramList extends StatelessWidget {
  const _ProgramList({
    required this.list,
    required this.systemApps,
    required this.onQueryChanged,
    required this.onOpenApp,
  });

  /// Main apps; [systemApps] render after a separator.
  final List<DesktopIcon> list;
  final List<DesktopIcon> systemApps;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<DesktopIcon> onOpenApp;

  @override
  Widget build(BuildContext context) {
    final isEmpty = list.isEmpty && systemApps.isEmpty;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchBox(onChanged: onQueryChanged),
            const SizedBox(height: 10),
            Text(
              'Programs',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: Colors.blueGrey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: isEmpty
                  ? Center(
                      child: Text(
                        'No programs match your search.',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey.shade400,
                        ),
                      ),
                    )
                  : ListView(
                      children: [
                        for (final icon in list)
                          StartMenuListTile(
                            key: ValueKey('start_menu_${icon.id}'),
                            title: icon.title,
                            icon: icon.icon,
                            onTap: () => onOpenApp(icon),
                          ),
                        if (list.isNotEmpty && systemApps.isNotEmpty)
                          const _MenuDivider(),
                        for (final icon in systemApps)
                          StartMenuListTile(
                            key: ValueKey('start_menu_${icon.id}'),
                            title: icon.title,
                            icon: icon.icon,
                            onTap: () => onOpenApp(icon),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBox extends StatefulWidget {
  const _SearchBox({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<_SearchBox> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF7A9FCC)),
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: TextField(
        key: const ValueKey('start_menu_search'),
        controller: _controller,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: 'Search programs',
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _UserRail extends StatelessWidget {
  const _UserRail({
    required this.name,
    required this.role,
    required this.onGitHub,
    required this.onEmail,
    required this.onSleep,
    required this.onShutDown,
  });

  final String name;
  final String role;
  final VoidCallback onGitHub;
  final VoidCallback onEmail;
  final VoidCallback onSleep;
  final VoidCallback onShutDown;

  static const _railGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xE61A3A5C),
      Color(0xF00A1E38),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: const BoxDecoration(
        gradient: _railGradient,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2567A5),
                border: Border.all(color: Colors.white70, width: 2),
              ),
              child: const Text(
                'EN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white24),
          const SizedBox(height: 6),
          _RailLink(
            key: const ValueKey('start_menu_github'),
            icon: Icons.code,
            label: 'GitHub',
            onTap: onGitHub,
          ),
          _RailLink(
            key: const ValueKey('start_menu_email'),
            icon: Icons.email_outlined,
            label: 'Email',
            onTap: onEmail,
          ),
          const Spacer(),
          _RailLink(
            key: const ValueKey('start_menu_sleep'),
            icon: Icons.dark_mode_outlined,
            label: 'Sleep',
            onTap: onSleep,
          ),
          _RailLink(
            key: const ValueKey('start_menu_shutdown'),
            icon: Icons.power_settings_new,
            label: 'Shut Down',
            onTap: onShutDown,
          ),
        ],
      ),
    );
  }
}

class _RailLink extends StatefulWidget {
  const _RailLink({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_RailLink> createState() => _RailLinkState();
}

class _RailLinkState extends State<_RailLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 15,
                color: _hovered ? Colors.white : Colors.white.withValues(alpha: 0.85),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12,
                  color: _hovered ? Colors.white : Colors.white.withValues(alpha: 0.9),
                  decoration: _hovered ? TextDecoration.underline : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Divider(height: 1, color: Color(0xFFC3D6E8)),
    );
  }
}

class StartMenuListTile extends StatelessWidget {
  const StartMenuListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: IconTheme(
        data: const IconThemeData(size: 20, color: Color(0xFF2567A5)),
        child: icon,
      ),
      title: Text(title, style: const TextStyle(fontSize: 13)),
      hoverColor: const Color(0xFFE5F3FF),
      onTap: onTap,
    );
  }
}
