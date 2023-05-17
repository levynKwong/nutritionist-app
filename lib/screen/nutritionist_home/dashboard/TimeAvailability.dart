import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

class TimeAvailability extends StatefulWidget {
  final String userId;

  TimeAvailability({required this.userId});

  @override
  _TimeAvailabilityState createState() => _TimeAvailabilityState();
}

class _TimeAvailabilityState extends State<TimeAvailability> {
  List<bool> _timesAvailable = List.generate(12, (_) => true);
  // List<bool> _timesChecked = List.generate(12, (_) => false);
  Color _activeColor = getColor();
  Color _inactiveColor = Colors.grey;
  bool _loading = true;

  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
    // _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchData() async {
    final document = await FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.userId)
        .get();

    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      if (data.containsKey('timesAvailable')) {
        setState(() {
          _timesAvailable = List.from(data['timesAvailable']);
        });
      }

      // if (data.containsKey('timesChecked')) {
      //   setState(() {
      //     _timesChecked = List.from(data['timesChecked']);
      //   });
      // }
    }

    setState(() {
      _loading = false;
    });
  }

  void _toggleTimeAvailability(int index) {
    setState(() {
      _timesAvailable[index] = !_timesAvailable[index];
    });

    _updateFirestore();
  }

  // void _toggleTimeChecked(int index) {
  //   setState(() {
  //     _timesChecked[index] = !_timesChecked[index];
  //   });

  //   _updateFirestore();
  // }

  void _updateFirestore() {
    FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.userId)
        .set({
      'timesAvailable': _timesAvailable,
      // 'timesChecked': _timesChecked,
    }, SetOptions(merge: true));
  }

  // void _startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 5), (_) {
  //     print('5 seconds passed');
  //     final now = DateTime.now();
  //     if (_timesChecked.contains(true)) {
  //       if (now.hour == 14 && now.minute == 49) {
  //         for (int i = 0; i < _timesChecked.length; i++) {
  //           if (_timesChecked[i] == true) {
  //             _toggleTimeAvailability(i);
  //           }
  //         }
  //       }
  //       _timer?.cancel();
  //     }
  //   });
  // }

  // void _updateTimesAvailable() {
  //   setState(() {
  //     _timesAvailable = List.generate(12, (index) => _timesChecked[index]);
  //   });
  //   _updateFirestore();
  // }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    return AlertDialog(
      title: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Time Availability',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height_ * 0.01,
                ),
                Text(
                  'Select the time you are available by toggling the switch',
                  style: TextStyle(fontSize: width_ * 0.05, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
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
                // Checkbox(
                //   value: _timesChecked[index],
                //   onChanged: (value) {
                //     _toggleTimeChecked(index);
                //   },
                // ),
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
            backgroundColor: getColor(), // change the color here
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
