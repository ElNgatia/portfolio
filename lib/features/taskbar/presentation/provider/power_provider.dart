import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Machine-like power states for the portfolio OS.
enum PowerState { awake, sleeping, shuttingDown, off }

/// Controls the power state. UI-agnostic: callers decide what closing
/// windows or showing overlays looks like.
class PowerController extends Notifier<PowerState> {
  @override
  PowerState build() => PowerState.awake;

  void sleep() => state = PowerState.sleeping;

  void wake() => state = PowerState.awake;

  /// Transitions through [PowerState.shuttingDown] (giving overlays time
  /// to animate) before settling into [PowerState.off].
  Future<void> shutDown({
    Duration duration = const Duration(milliseconds: 1800),
  }) async {
    if (state == PowerState.shuttingDown || state == PowerState.off) return;
    state = PowerState.shuttingDown;
    await Future<void>.delayed(duration);
    state = PowerState.off;
  }

  void powerOn() => state = PowerState.awake;
}

final powerProvider =
    NotifierProvider<PowerController, PowerState>(PowerController.new);
