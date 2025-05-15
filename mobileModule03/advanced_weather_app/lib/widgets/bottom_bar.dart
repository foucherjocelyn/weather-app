import 'package:flutter/material.dart';


class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: TabBar(
        tabs: const <Widget>[
          Tab(icon: Icon(Icons.access_time), text: 'Currently'),
          Tab(icon: Icon(Icons.calendar_today), text: 'Today'),
          Tab(icon: Icon(Icons.date_range), text: 'Weekly'),
        ],
      ),
    );
  }
}
