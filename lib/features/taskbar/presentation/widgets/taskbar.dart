import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';
import 'package:portfolio/features/taskbar/presentation/widgets/menu.dart';

class TaskBar extends ConsumerStatefulWidget {
  const TaskBar({super.key});

  @override
  ConsumerState<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends ConsumerState<TaskBar> {
  @override
  Widget build(BuildContext context) {
    final openWindows = ref
        .watch(windowManagerProvider)
        .entries
        .where((entry) => entry.value.isOpen)
        .map((entry) => entry.value)
        .toList();
    final wm = ref.watch(windowManagerProvider.notifier);
    final nowAsync = ref.watch(nowProvider).value ?? DateTime.now();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
        color: Colors.transparent,

        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: .1),
        ),
      ),
      height: 50,
      child: Row(
        spacing: 8,
        children: [
          IconButton(
            onPressed: () {
              showPopover(
                context: context,
                bodyBuilder: (context) {
                  return StartMenu();
                },
                transition: PopoverTransition.other,
                direction: PopoverDirection.top,
                backgroundColor: Colors.white.withValues(alpha: 0.6),
              );
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),

          for (final window in openWindows)
            InkWell(
              key: ValueKey('taskbar_icon_${window.id}'),
              onTap: () {
                wm.restoreWindow(window.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      window.icon.icon,
                      key: ValueKey('taskbar_icon_${window.id}'),
                      size: 16,
                      color: (window.isFocused && !window.isMinimized)
                          ? Colors.white
                          : Colors.white70,
                    ),
                    Text(
                      window.title,
                      style: TextStyle(
                        fontSize: 10,
                        color: (window.isFocused && !window.isMinimized)
                            ? Colors.white
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Spacer(),

          Icon(
            Icons.volume_down,
            color:
                ThemeData.estimateBrightnessForColor(Colors.black) ==
                    Brightness.dark
                ? Colors.white
                : Colors.black,
          ),

          Icon(Icons.network_cell, color: Colors.green),

          //Time and date
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "${'${nowAsync.hour.toString().padLeft(2, '0')}:${nowAsync.minute.toString().padLeft(2, '0')}'}\n${'${nowAsync.day.toString().padLeft(2, '0')}/${nowAsync.month.toString().padLeft(2, '0')}/${nowAsync.year}'}",
              style: TextStyle(
                fontSize: 16,
                color:
                    ThemeData.estimateBrightnessForColor(Colors.black) ==
                        Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
