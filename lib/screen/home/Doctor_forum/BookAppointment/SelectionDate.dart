import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectionDate extends StatefulWidget {
  final String nutritionistUid;
  final String nutritionistName;
  const SelectionDate(
      {super.key,
      required this.nutritionistUid,
      required this.nutritionistName});

  @override
  State<SelectionDate> createState() =>
      _SelectionDateState(nutritionistUid, nutritionistName);
}

class _SelectionDateState extends State<SelectionDate> {
  final String nutritionistUid;
  final String nutritionistName;
  _SelectionDateState(this.nutritionistUid, this.nutritionistName);
  int? _selectedValue;

  DateTime today = DateTime.now();
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
    _calendarFormat = CalendarFormat.month;
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDay = day;
      _focusedDay = focusedDay; // You also need to update the focused day
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarTop(
        titleText: 'Book Appointment',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height_ * 0.01,
              ),
              topSubTitle(width_, height_),
              calendar(width_, height_),
              SizedBox(
                height: height_ * 0.02,
              ),
              Text5(text: 'SLOTS AVAILABLE :'),
              SizedBox(
                height: height_ * 0.02,
              ),
              buttons(height_, width_)
            ],
          ),
        ),
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: width_ * 0.03,
          ),
          Text5(text: 'Select the time to visit Dr $nutritionistName'),
        ],
      ),
    );
  }

  Widget calendar(double width_, double height_) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                locale: 'en_US',
                rowHeight: height_ * 0.052, //43
                headerStyle:
                    HeaderStyle(formatButtonVisible: true, titleCentered: true),
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: _onDaySelected,
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(color: Colors.black),
                  todayTextStyle:
                      const TextStyle(color: Color.fromARGB(255, 54, 82, 244)),
                ),
              ),
            ),
            SizedBox(
              height: height_ * 0.02,
            ),
            Text5(text: 'Selected day: ${_selectedDay.toLocal()}'),
          ],
        ),
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width_ * 0.3, 50),
            primary: Color(0xFF575ecb), // set background color
            onPrimary: Colors.white, // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('        Back       '),
        ),
        SizedBox(width: width_ * 0.15), // add some spacing between the buttons
        ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => paymentAppointment(),
            //   ),
            // );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width_ * 0.3, 50),
            primary: Color(0xFF575ecb), // set background color
            onPrimary: Colors.white, // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('         Next         '),
        ),
      ],
    ));
  }
}
