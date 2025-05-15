import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.secondary;
    
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.access_time, color: iconColor),
              child: Text(
                'Currently',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Tab(
              icon: Icon(Icons.calendar_today, color: iconColor),
              child: Text(
                'Today',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Tab(
              icon: Icon(Icons.date_range, color: iconColor),
              child: Text(
                'Weekly',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
