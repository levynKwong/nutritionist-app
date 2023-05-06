import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/nutritionist_home/dashboard/TimeAvailability.dart';
import 'package:table_calendar/table_calendar.dart';

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

class appBarTopBack extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const appBarTopBack({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      backgroundColor: getColor(),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        NotificationWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class appBarTopCal extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const appBarTopCal({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return AppBar(
      title: Text(titleText),
      backgroundColor: getColor(),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.more_time,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TimeAvailability(
                    userId: '1234',
                  );
                },
              );
            }),
        IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              popUpButton(context);
            }),
        NotificationWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Future<dynamic> popUpButton(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width_ = constraints.maxWidth;
          final double height_ = constraints.maxHeight;
          final double contentHeight = height_ * 0.45;
          final double contentWidth = width_ * 0.8;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              height: contentHeight,
              width: contentWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                // Add any additional calendar properties here
              ),
            ),
          );
        },
      );
    },
  );
}
