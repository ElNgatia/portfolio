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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icons = ref.watch(desktopIconsProvider);
    final wm = ref.read(windowManagerProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final medium = (width - _sidePadding * 2 - _gutter) / 2;
        final wide = medium * 2 + _gutter;
        // Vertical room for the label under medium tiles.
        const labelExtent = 26.0;

        DesktopIcon? iconFor(String id) => icons
            .where((icon) => icon.id == id)
            .firstOrNull;

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

        Widget mediumRow(MetroTileSpec left, MetroTileSpec right) {
          return Padding(
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
                  child: SizedBox(
                    height: medium + labelExtent,
                    child: tile(right),
                  ),
                ),
              ],
            ),
          );
        }

        Widget wideRow(MetroTileSpec spec, Widget? content) {
          return Padding(
            padding: const EdgeInsets.only(bottom: _gutter),
            child: SizedBox(
              width: wide,
              height: medium,
              child: tile(spec, content: content),
            ),
          );
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
                    children: [
                      wideRow(kMetroTileSpecs[0], _aboutTileContent()),
                      mediumRow(kMetroTileSpecs[1], kMetroTileSpecs[2]),
                      wideRow(kMetroTileSpecs[3], _experienceTileContent()),
                      mediumRow(kMetroTileSpecs[4], kMetroTileSpecs[5]),
                      mediumRow(kMetroTileSpecs[6], kMetroTileSpecs[7]),
                      Padding(
                        padding: const EdgeInsets.only(bottom: _gutter),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: medium,
                              height: medium + labelExtent,
                              child: tile(kMetroTileSpecs[8]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _aboutTileContent() {
    return MetroWideTileContent(
      title: 'Elvis Ngatia',
      subtitle: 'Mobile Engineer · Flutter · Offline-first systems',
      leading: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 2),
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

  Widget _experienceTileContent() {
    return const MetroWideTileContent(
      title: 'Experience',
      subtitle: 'Mobile Engineer · Solutech Limited · Nairobi',
      trailingIcon: Icons.work,
    );
  }
}
