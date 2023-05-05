import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
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
                  return TimeAvailability();
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

class TimeAvailability extends StatefulWidget {
  @override
  _TimeAvailabilityState createState() => _TimeAvailabilityState();
}

class _TimeAvailabilityState extends State<TimeAvailability> {
  List<bool> _timesAvailable = List.generate(12, (_) => true);
  Color _activeColor = getColor();
  Color _inactiveColor = Colors.grey;

  void _toggleTimeAvailability(int index) {
    setState(() {
      _timesAvailable[index] = !_timesAvailable[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Time Availability'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(12, (index) {
            final time = TimeOfDay(hour: index + 6, minute: 0);
            final formattedTime = time.format(context);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formattedTime),
                Switch(
                  value: _timesAvailable[index],
                  activeColor: _activeColor,
                  inactiveThumbColor: _inactiveColor,
                  onChanged: (value) {
                    _toggleTimeAvailability(index);
                  },
                ),
              ],
            );
          }),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // change the color here
          ),
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
