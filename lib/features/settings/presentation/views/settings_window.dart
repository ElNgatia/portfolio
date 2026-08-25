import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:portfolio/features/settings/presentation/provider/settings_provider.dart';

class SettingsWindow extends ConsumerStatefulWidget {
  const SettingsWindow({super.key});

  @override
  ConsumerState<SettingsWindow> createState() => _SettingsWindowState();
}

class _SettingsWindowState extends ConsumerState<SettingsWindow> {
  /// Wallpaper that was active when the settings window was opened.
  late WallpaperOption _originalWallpaper;

  @override
  void initState() {
    super.initState();
    _originalWallpaper = ref.read(settingsProvider).wallpaper;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final skin = SkinPalette.of(context);

    return Container(
      color: skin.pageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WindowSectionHeader(title: 'Desktop Background'),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your desktop background',
                    style: TextStyle(
                      fontSize: 13,
                      color: skin.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Wallpaper preview
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: skin.cardBorder),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: _buildWallpaperPreview(settings.wallpaper),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Select a wallpaper:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: skin.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Wallpaper options grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.6,
                      ),
                      itemCount: WallpaperOption.values.length,
                      itemBuilder: (context, index) {
                        final option = WallpaperOption.values[index];
                        final isSelected = settings.wallpaper == option;
                        return _WallpaperTile(
                          option: option,
                          isSelected: isSelected,
                          onTap: () => notifier.setWallpaper(option),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom OK/Cancel bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: skin.footerBarBackground,
              border: Border(top: BorderSide(color: skin.divider)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _SkinButton(
                  label: 'OK',
                  onPressed: () {
                    // Changes are already applied live; record new baseline.
                    _originalWallpaper = settings.wallpaper;
                  },
                ),
                const SizedBox(width: 8),
                _SkinButton(
                  label: 'Cancel',
                  onPressed: () {
                    // Revert to the wallpaper that was active when the
                    // settings window was opened.
                    notifier.setWallpaper(_originalWallpaper);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaperPreview(WallpaperOption option) {
    if (option.isAsset) {
      return Image.asset(option.assetPath!, fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: option.gradientColors!,
        ),
      ),
    );
  }
}

class _WallpaperTile extends StatelessWidget {
  const _WallpaperTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final WallpaperOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? skin.accent : skin.chipBorder,
                  width: isSelected ? 2.5 : 1,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: _buildTileBackground(),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            option.label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? skin.accent : skin.textPrimary,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileBackground() {
    if (option.isAsset) {
      return Image.asset(option.assetPath!, fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: option.gradientColors!,
        ),
      ),
    );
  }
}

class _SkinButton extends StatefulWidget {
  const _SkinButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_SkinButton> createState() => _SkinButtonState();
}

class _SkinButtonState extends State<_SkinButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 12, color: skin.textPrimary),
          ),
        ),
      ),
    );
  }
}
