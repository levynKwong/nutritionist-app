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
  List<bool> _timesChecked = List.generate(12, (_) => false);
  Color _activeColor = getColor();
  Color _inactiveColor = Colors.grey;
  bool _loading = true;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _startTimer();
  }

  void _fetchData() async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();

    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      if (data.containsKey('timesAvailable')) {
        setState(() {
          _timesAvailable = List.from(data['timesAvailable']);
        });
      }

      if (data.containsKey('timesChecked')) {
        setState(() {
          _timesChecked = List.from(data['timesChecked']);
        });
      }
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

  void _toggleTimeChecked(int index) {
    setState(() {
      _timesChecked[index] = !_timesChecked[index];
    });

    _updateFirestore();
  }

  void _updateFirestore() {
    FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'timesAvailable': _timesAvailable,
      'timesChecked': _timesChecked,
    }, SetOptions(merge: true));
  }

  void _startTimer() {
    final now = DateTime.now();
    final updateTime = DateTime(now.year, now.month, now.day, 0, 0);

    Duration duration = updateTime.difference(now);
    if (duration.isNegative) {
      duration += Duration(days: 1);
    }

    _timer = Timer(duration, _updateTimesAvailable);
  }

  void _updateTimesAvailable() {
    setState(() {
      _timesAvailable = List.generate(12, (index) => _timesChecked[index]);
    });
    _updateFirestore();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    final specificTime = TimeOfDay(hour: 15, minute: 5);

    final now = DateTime.now();
    final todaySpecificTime = DateTime(
        now.year, now.month, now.day, specificTime.hour, specificTime.minute);

    final diff = todaySpecificTime.difference(now).inSeconds;
    final fiveSecondsAgo = DateTime.now().subtract(Duration(seconds: 5));
    final fiveSecondsAgoSecond =
        fiveSecondsAgo.second - (fiveSecondsAgo.second % 5);

    if (diff.abs() < 5 && now.second == fiveSecondsAgoSecond) {
      setState(() {
        _timesAvailable = List.generate(12, (index) => _timesChecked[index]);
      });
      _updateFirestore();
    }

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
                Checkbox(
                  value: _timesChecked[index],
                  onChanged: (value) {
                    _toggleTimeChecked(index);
                  },
                ),
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
