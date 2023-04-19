import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

class ColorChangingButton extends StatefulWidget {
  final Color defaultColor;
  final Color selectedColor;
  final String text;
  final Function onPressed;
  final dynamic value;
  final dynamic groupValue;
  const ColorChangingButton({
    Key? key,
    required this.defaultColor,
    required this.selectedColor,
    required this.text,
    required this.onPressed,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  @override
  _ColorChangingButtonState createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  bool _isSelected = false;
  String? _selectedText;
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.value == widget.groupValue;
    _isSelected = isSelected;
    final color = _isSelected ? widget.selectedColor : widget.defaultColor;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.onPressed(widget.value);
        });
      },
      child: Text(widget.text),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}

class selectionDate extends StatefulWidget {
  const selectionDate({super.key});

  @override
  State<selectionDate> createState() => _selectionDateState();
}

class _selectionDateState extends State<selectionDate> {
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

  TimeButton(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.68),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorChangingButton(
                defaultColor: Color(0xFF8F8F8F),
                selectedColor: Color(0xFF676ef1),
                text: '8.00',
                onPressed: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                value: 1,
                groupValue: _selectedValue,
              ),
              SizedBox(width: width_ * 0.05),
              ColorChangingButton(
                defaultColor: Color(0xFF8F8F8F),
                selectedColor: Color(0xFF676ef1),
                text: '9.30',
                onPressed: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                value: 2,
                groupValue: _selectedValue,
              ),
              SizedBox(width: width_ * 0.05),
              ColorChangingButton(
                defaultColor: Color(0xFF8F8F8F),
                selectedColor: Color(0xFF676ef1),
                text: '11.00',
                onPressed: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                value: 3,
                groupValue: _selectedValue,
              ),
            ],
          ),
          SizedBox(height: height_ * 0.05),
          Container(
            child: (() {
              switch (_selectedValue) {
                case 1:
                  return Text('Selected time: 8.00');
                case 2:
                  return Text('Selected time: 9.30');
                case 3:
                  return Text('Selected time: 11.00');
                default:
                  return Text('Selected time: ');
              }
            })(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          background(),
          topTitle(width_, height_),
          topSubTitle(width_, height_),
          calendar(width_, height_),
          Container(
            margin: EdgeInsets.only(top: height_ * 0.3, right: width_ * 0.55),
            child: Text5(text: 'SLOTS AVAILABLE :'),
          ),
          TimeButton(width_, height_),
          buttons(height_, width_),
        ],
      ),
    );
  }

  topTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.82, left: width_ * 0.05),
      child: Row(
        children: [
          Text6(text: 'Select Date and Time'),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: NotificationWidget(),
            ),
          ),
        ],
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.74, left: width_ * 0.05),
      child: Row(
        children: [
          Text5(text: 'Select the time to visit Dr.Amelia'),
        ],
      ),
    );
  }

  NutritionistService(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('Button pressed');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: height_ * 0.032, horizontal: width_ * 0.07),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/nutritionist.png',
                    width: width_ * 0.2,
                    height: height_ * 0.06,
                  ),
                  SizedBox(height: height_ * 0.01),
                  Text7(text: 'Nutritionist'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        margin: EdgeInsets.only(top: height_ * 0.9),
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
            SizedBox(
                width: width_ * 0.15), // add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NutritionistBookAppointment(),
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

  Widget calendar(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.2),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                locale: 'en_US',
                rowHeight: 43,
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
            Text5(text: 'Selected day: ${_selectedDay.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
