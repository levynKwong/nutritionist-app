import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          appBar(width_),
        ],
      ),
    );
  }

  AppBar appBar(double width_) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.black,
          fontSize: width_ * 0.07,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
          onPressed: () {
            // Add your code here for calendar icon action
          },
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            // Add your code here for notification icon action
          },
        ),
      ],
    );
  }
}
