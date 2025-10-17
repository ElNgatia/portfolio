import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/taskbar/presentation/provider/time_provider.dart';

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
    final nowAsync = ref.watch(nowProvider).value;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],

        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        ),
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      height: 50,
      child: Row(
        spacing: 8,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          // SearchBar(),
          AboutMeIcon(
            onTap: () {},
          ),
          for (final window in openWindows)
            IconButton(
              onPressed: () {
                wm.restoreWindow(window.id);
              },
              icon: Icon(
                Icons.window,
                color: window.isFocused ? Colors.blueAccent : Colors.black87,
              ),
            ),

          // Add minimized windows here
          Spacer(),

          Icon(Icons.volume_down, color: Colors.black),

          Icon(Icons.network_cell, color: Colors.green),

          //Time and date
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "${nowAsync != null ? '${nowAsync.hour.toString().padLeft(2, '0')}:${nowAsync.minute.toString().padLeft(2, '0')}' : '--:--'}\n${nowAsync != null ? '${nowAsync.day.toString().padLeft(2, '0')}/${nowAsync.month.toString().padLeft(2, '0')}/${nowAsync.year}' : '--/--/----'}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutMeIcon extends StatelessWidget {
  const AboutMeIcon({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: Icon(Icons.person));
  }
}
