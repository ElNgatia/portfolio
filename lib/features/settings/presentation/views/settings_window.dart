import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Container(
      color: const Color(0xFFECE9D8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Settings header
          Container(
            width: double.infinity,
            color: const Color(0xFF0A246A),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Text(
              'Desktop Background',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your desktop background',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Wallpaper preview
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF7A9FCC)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: _buildWallpaperPreview(settings.wallpaper),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Select a wallpaper:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
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
            decoration: const BoxDecoration(
              color: Color(0xFFD4D0C8),
              border: Border(
                top: BorderSide(color: Color(0xFF808080)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _Win7Button(
                  label: 'OK',
                  onPressed: () {
                    // Changes are already applied live; record new baseline.
                    _originalWallpaper = settings.wallpaper;
                  },
                ),
                const SizedBox(width: 8),
                _Win7Button(
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0078D7)
                      : const Color(0xFF808080),
                  width: isSelected ? 2.5 : 1,
                ),
                borderRadius: BorderRadius.circular(3),
                boxShadow: isSelected
                    ? [
                        const BoxShadow(
                          color: Color(0x440078D7),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
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
              color: isSelected
                  ? const Color(0xFF0078D7)
                  : const Color(0xFF000000),
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

class _Win7Button extends StatefulWidget {
  const _Win7Button({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_Win7Button> createState() => _Win7ButtonState();
}

class _Win7ButtonState extends State<_Win7Button> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
                  ? [const Color(0xFFE5F3FF), const Color(0xFFCCE4FF)]
                  : [const Color(0xFFF5F5F5), const Color(0xFFDCDCDC)],
            ),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF3C9BE0)
                  : const Color(0xFFADADAD),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

