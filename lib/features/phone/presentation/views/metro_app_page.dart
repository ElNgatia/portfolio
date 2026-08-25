import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/desktop/presentation/widgets/window_content_router.dart';
import 'package:portfolio/features/phone/presentation/widgets/metro_status_bar.dart';
import 'package:portfolio/features/phone/presentation/widgets/metro_theme.dart';

/// Full-screen Windows Phone app page: status bar, big light header with
/// a circular back chevron, the app content and a bottom application bar.
class MetroAppPage extends ConsumerWidget {
  const MetroAppPage({super.key, required this.window});

  final WindowEntity window;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accent = metroAccentFor(window.id);

    return Container(
      color: MetroColors.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MetroStatusBar(),

            // Page header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  _MetroCircleButton(
                    key: ValueKey('metro_back_${window.id}'),
                    icon: Icons.chevron_left,
                    semanticLabel: 'Back to Start',
                    onPressed: () => ref
                        .read(windowManagerProvider.notifier)
                        .closeWindow(window.id),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      window.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Accent underline, very Metro
            Container(
              width: 56,
              height: 3,
              margin: const EdgeInsets.only(left: 60, top: 6),
              color: accent,
            ),

            // Content — rendered in the Metro skin, tinted with the
            // app's accent colour.
            Expanded(
              child: SkinScope(
                palette: metroSkin(accent),
                child: windowContentFor(window),
              ),
            ),

            // Application bar
            Container(
              height: 64,
              width: double.infinity,
              color: MetroColors.appBar,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _MetroCircleButton(
                    key: ValueKey('metro_home_${window.id}'),
                    icon: Icons.grid_view_outlined,
                    semanticLabel: 'Go to Start',
                    onPressed: () => ref
                        .read(windowManagerProvider.notifier)
                        .closeWindow(window.id),
                  ),
                  const Spacer(),
                  Text(
                    'ELVIS NGATIA',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                      letterSpacing: 1.5,
                    ),
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

/// Circular outlined button used across the Metro shell.
class _MetroCircleButton extends StatelessWidget {
  const _MetroCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.9),
              width: 1.5,
            ),
          ),
          child: Icon(icon, size: 26, color: Colors.white),
        ),
      ),
    );
  }
}
