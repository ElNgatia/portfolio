import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';

/// Slim Windows Phone status bar: signal on the left, clock and battery
/// on the right.
class MetroStatusBar extends ConsumerWidget {
  const MetroStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(nowProvider).value ?? DateTime.now();
    final hh = now.hour.toString().padLeft(2, '0');
    final mm = now.minute.toString().padLeft(2, '0');

    return Container(
      height: 28,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.signal_cellular_alt, size: 14, color: Colors.white),
          const Spacer(),
          Text(
            '$hh:$mm',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.wifi, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          const Icon(Icons.battery_full, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}
