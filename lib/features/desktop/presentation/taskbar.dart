import 'package:flutter/material.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({super.key});

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
