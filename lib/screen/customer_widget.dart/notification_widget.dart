import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0, // add elevation to bring the widget to the foreground
      color: Colors.transparent, // set background color to transparent
      child: InkWell(
        onTap: () {
          // Handle the onTap event here
          // For example, navigate to a notification screen
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.notifications),
        ),
      ),
    );
  }
}
