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
          SearchBar(),
          AboutMeIcon(
            onTap: () {},
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          //Time and date
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "${DateTime.now().hour}:${DateTime.now().minute}",
              style: TextStyle(fontSize: 16),
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

class AboutMeWindow extends StatelessWidget {
  const AboutMeWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      color: Colors.white,
      child: Column(
        children: [
          Text("About Me"),
          Text("Name: John Doe"),
          Text("Email:"),
        ],
      ),
    );
  }
}
