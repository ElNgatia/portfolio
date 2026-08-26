import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/taskbar/presentation/provider/power_provider.dart';

/// Full-screen overlays for the sleep / shutting-down / off states.
/// Mount inside a [Stack] under [Positioned.fill]; renders nothing while
/// [PowerState.awake].
class PowerOverlay extends ConsumerWidget {
  const PowerOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(powerProvider);
    return switch (state) {
      PowerState.awake => const SizedBox.shrink(),
      PowerState.sleeping => const _SleepOverlay(),
      PowerState.shuttingDown => const _ShuttingDownOverlay(),
      PowerState.off => const _PoweredOffOverlay(),
    };
  }
}

/// Black screen; any click or key press wakes the machine.
class _SleepOverlay extends ConsumerWidget {
  const _SleepOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void wake() => ref.read(powerProvider.notifier).wake();

    return Focus(
      autofocus: true,
      onKeyEvent: (_, __) {
        wake();
        return KeyEventResult.handled;
      },
      child: GestureDetector(
        key: const ValueKey('power_sleep_overlay'),
        onTap: wake,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 48),
          child: Text(
            'Sleeping — click anywhere or press a key to wake',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Spinner + label shown while the shut-down sequence runs.
class _ShuttingDownOverlay extends StatelessWidget {
  const _ShuttingDownOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('power_shutting_down_overlay'),
      color: Colors.black,
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Shutting down…',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Black screen with a power button to boot back up.
class _PoweredOffOverlay extends ConsumerWidget {
  const _PoweredOffOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      key: const ValueKey('power_off_overlay'),
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "It's now safe to close this tab.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 24),
          _PowerButton(onPressed: () {
            ref.read(powerProvider.notifier).powerOn();
          }),
        ],
      ),
    );
  }
}

class _PowerButton extends StatefulWidget {
  const _PowerButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<_PowerButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Power on',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          key: const ValueKey('power_on_button'),
          onTap: widget.onPressed,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    _hovered ? const Color(0xFF1BA1E2) : Colors.white38,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.power_settings_new,
              size: 26,
              color: _hovered ? const Color(0xFF1BA1E2) : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
