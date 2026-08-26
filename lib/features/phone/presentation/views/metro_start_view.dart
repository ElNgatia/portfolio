import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/domain/entity/desktop_icon.dart';
import 'package:portfolio/features/desktop/presentation/provider/desktop_icons_provider.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/phone/presentation/widgets/metro_status_bar.dart';
import 'package:portfolio/features/phone/presentation/widgets/metro_theme.dart';
import 'package:portfolio/features/phone/presentation/widgets/metro_tile.dart';

/// Windows Phone Start screen: a black canvas of accent-coloured live
/// tiles, two columns wide.
class MetroStartView extends ConsumerWidget {
  const MetroStartView({super.key});

  static const _sidePadding = 12.0;
  static const _gutter = 12.0;

  /// Rich content for specific wide tiles, keyed by app id.
  static const Map<String, WidgetBuilder> _wideTileContent = {
    '123': _buildAboutTileContent,
    '789': _buildExperienceTileContent,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icons = ref.watch(desktopIconsProvider);
    final wm = ref.read(windowManagerProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final medium = (width - _sidePadding * 2 - _gutter) / 2;
        // Vertical room for the label under medium tiles.
        const labelExtent = 26.0;

        DesktopIcon? iconFor(String id) =>
            icons.where((icon) => icon.id == id).firstOrNull;

        void open(DesktopIcon? icon) {
          if (icon == null) return;
          wm.openApp(icon, MediaQuery.sizeOf(context));
        }

        Widget tile(MetroTileSpec spec, {Widget? content}) {
          final icon = iconFor(spec.id);
          if (icon == null) return const SizedBox.shrink();
          return MetroTile(
            key: ValueKey('metro_tile_${spec.id}'),
            title: icon.title,
            icon: icon.icon.icon,
            accent: spec.accent,
            size: spec.size,
            content: content,
            onTap: () => open(icon),
          );
        }

        // Walk the specs in order: wide tiles take a full row, mediums
        // pair up two per row so the grid adapts as apps are added.
        List<Widget> buildRows() {
          final rows = <Widget>[];
          var pendingMediums = <MetroTileSpec>[];

          void flushMediums() {
            for (var i = 0; i < pendingMediums.length; i += 2) {
              final left = pendingMediums[i];
              final right =
                  i + 1 < pendingMediums.length ? pendingMediums[i + 1] : null;
              rows.add(
                Padding(
                  padding: const EdgeInsets.only(bottom: _gutter),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: medium,
                        height: medium + labelExtent,
                        child: tile(left),
                      ),
                      SizedBox(width: _gutter),
                      Expanded(
                        child: right == null
                            ? const SizedBox()
                            : SizedBox(
                                height: medium + labelExtent,
                                child: tile(right),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }
            pendingMediums = [];
          }

          for (final spec in kMetroTileSpecs) {
            if (spec.size == MetroTileSize.wide) {
              flushMediums();
              final builder = _wideTileContent[spec.id];
              rows.add(
                Padding(
                  padding: const EdgeInsets.only(bottom: _gutter),
                  child: SizedBox(
                    width: medium * 2 + _gutter,
                    height: medium,
                    child: tile(
                      spec,
                      content: builder?.call(context),
                    ),
                  ),
                ),
              );
            } else {
              pendingMediums.add(spec);
            }
          }
          flushMediums();
          return rows;
        }

        return Container(
          color: MetroColors.background,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MetroStatusBar(),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      _sidePadding, 8, _sidePadding, 24,
                    ),
                    children: buildRows(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildAboutTileContent(BuildContext context) {
    return MetroWideTileContent(
      title: 'Elvis Ngatia',
      subtitle: 'Mobile Engineer · Flutter · Offline-first systems',
      leading: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(color: Colors.white.withValues(alpha: 0.9), width: 2),
        ),
        child: const Text(
          'EN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static Widget _buildExperienceTileContent(BuildContext context) {
    return const MetroWideTileContent(
      title: 'Experience',
      subtitle: 'Mobile Engineer · Solutech Limited · Nairobi',
      trailingIcon: Icons.work,
    );
  }
}
