import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/presentation/taskbar.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.blue),
        Align(alignment: Alignment.bottomCenter, child: TaskBar()),
        Align(
          alignment: Alignment.center,
          child: Draggable(
            data: Container(),
            feedback: Container(
              height: 200,
              width: 200,
              color: Colors.red.withOpacity(0.5),
            ),
            child: Container(height: 200, width: 200, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
