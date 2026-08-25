import 'package:flutter/material.dart';

import 'metro_theme.dart';

/// A Windows Phone live-style tile.
///
/// Medium tiles render as a square with the label below; wide tiles span
/// both columns, carry custom [content] and put the label inside at the
/// bottom-left. Pressing darkens/shrinks the tile like WP did.
class MetroTile extends StatefulWidget {
  const MetroTile({
    super.key,
    required this.title,
    required this.accent,
    required this.size,
    required this.onTap,
    this.icon,
    this.content,
  });

  final String title;
  final Color accent;
  final MetroTileSize size;
  final VoidCallback onTap;
  final IconData? icon;

  /// Optional rich content for wide tiles.
  final Widget? content;

  @override
  State<MetroTile> createState() => _MetroTileState();
}

class _MetroTileState extends State<MetroTile> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    final face = GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          foregroundDecoration: BoxDecoration(
            color: _pressed ? Colors.white.withValues(alpha: 0.15) : null,
          ),
          decoration: BoxDecoration(color: widget.accent),
          child:
              widget.content ??
              Center(
                child: Icon(
                  widget.icon,
                  size: 44,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.size == MetroTileSize.medium)
          AspectRatio(aspectRatio: 1, child: face)
        else
          Expanded(child: face),
        if (widget.size == MetroTileSize.medium) ...[
          const SizedBox(height: 6),
          Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}

/// Wide-tile inner layout: big light title over a subtle subtitle.
class MetroWideTileContent extends StatelessWidget {
  const MetroWideTileContent({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailingIcon,
  });

  final String title;
  final String subtitle;
  final Widget? leading;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 10)],
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  size: 30,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
