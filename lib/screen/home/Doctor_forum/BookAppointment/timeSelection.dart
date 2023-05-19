import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/paymentAppointment.dart';

class TimeAvailabilityScreen extends StatefulWidget {
  final String userId;
  final String nutritionistId;
  final String date;

  TimeAvailabilityScreen(
      {required this.userId, required this.nutritionistId, required this.date});

  @override
  _TimeAvailabilityScreenState createState() =>
      _TimeAvailabilityScreenState(userId, nutritionistId, date);
}

class _TimeAvailabilityScreenState extends State<TimeAvailabilityScreen> {
  final String userId;
  final String nutritionistId;
  final String date;
  _TimeAvailabilityScreenState(this.userId, this.nutritionistId, this.date);
  late Stream<List<bool>> _timeAvailabilityStream;
  List<bool> _selectedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _timeAvailabilityStream = FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.nutritionistId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null && data['timesAvailable'] != null) {
        return List<bool>.from(data['timesAvailable']);
      } else {
        return <bool>[];
      }
    });
    _selectedTimeSlots = List<bool>.filled(_selectedTimeSlots.length, false);
  }

  void _toggleSelection(int index) {
    setState(() {
      for (int i = 0; i < _selectedTimeSlots.length; i++) {
        if (i == index) {
          _selectedTimeSlots[i] = false;
        } else {
          _selectedTimeSlots[i] = true;
        }
      }
    });
  }

  List<int> _getAvailableTimeSlots(List<bool> timeAvailable) {
    final availableTimeSlots = <int>[];
    for (int i = 0; i < timeAvailable.length; i++) {
      availableTimeSlots.add(i);
    }
    return availableTimeSlots;
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
        child: StreamBuilder<List<bool>>(
          stream: _timeAvailabilityStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final timeAvailable = snapshot.data!;
            if (_selectedTimeSlots.length != timeAvailable.length) {
              _selectedTimeSlots =
                  List<bool>.filled(timeAvailable.length, false);
            }
            if (timeAvailable.isEmpty) {
              return Text('No time slots available');
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Wrap(
                      runSpacing: 8.0, // set space between rows
                      children: List.generate(
                        _getAvailableTimeSlots(timeAvailable).length,
                        (index) {
                          final isSelected = _selectedTimeSlots[index];
                          final availableIndex =
                              _getAvailableTimeSlots(timeAvailable)[index];
                          final timeSlot = ' ${availableIndex + 6}:00';
                          return SizedBox(
                            width: width_ * 0.3, // set width of button
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: width_ * 0.01),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (timeAvailable[_getAvailableTimeSlots(
                                      timeAvailable)[index]]) {
                                    _toggleSelection(index);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) {
                                      if (isSelected) {
                                        return Colors.grey;
                                      } else {
                                        // If the corresponding boolean value in _selectedTimeSlots is false, disable the button and set its color to grey.
                                        if (!timeAvailable[
                                            _getAvailableTimeSlots(
                                                timeAvailable)[index]]) {
                                          return Color.fromARGB(
                                              255, 168, 72, 72);
                                        } else {
                                          return getColor();
                                        }
                                      }
                                    },
                                  ),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 30)),
                                ),
                                child: Text(
                                  timeSlot,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height_ * 0.01),
                  buttons(height_, width_)
                ],
              );
            }
          },
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
            foregroundColor: Colors.white, backgroundColor: Color(0xFF575ecb),
            minimumSize: Size(width_ * 0.3, 50), // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('        Back       '),
        ),
        SizedBox(width: width_ * 0.15), // add some spacing between the buttons
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => paymentAppointment(
                  nutritionistUid: nutritionistId,
                  userId: currentId,
                  date: date,
                  timeAvailable: _selectedTimeSlots,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF575ecb),
            minimumSize: Size(width_ * 0.3, 50), // set text color
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
