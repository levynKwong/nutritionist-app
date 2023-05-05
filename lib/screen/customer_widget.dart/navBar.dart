import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';

class appBarTop extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const appBarTop({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      backgroundColor: getColor(),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        NotificationWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class appBarTopSearch extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const appBarTopSearch({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      backgroundColor: getColor(),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // TODO: Implement search functionality
          },
        ),
        NotificationWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
