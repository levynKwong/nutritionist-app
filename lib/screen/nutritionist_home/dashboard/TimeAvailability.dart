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
  // Color _activeColor = getColor(context);
  Color _inactiveColor = Colors.grey;
  bool _loading = true;
  bool _lockToggle = false;

  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
    _fetchDataLock();
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
    }

    setState(() {
      _loading = false;
    });
  }

  void _fetchDataLock() async {
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
      if (data.containsKey('lock')) {
        setState(() {
          _lockToggle = data['lock'];
        });
      }
    }

    setState(() {
      _loading = false;
    });
  }

  void _toggleLock() {
    setState(() {
      _lockToggle = !_lockToggle;
    });

    _updateFirestoreLock();
  }

  void _updateFirestoreLock() {
    FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.userId)
        .set({
      'lock': _lockToggle,
    }, SetOptions(merge: true));
  }

  void _toggleTimeAvailability(int index) {
    setState(() {
      _timesAvailable[index] = !_timesAvailable[index];
    });

    _updateFirestore();
  }

  void _updateFirestore() {
    FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.userId)
        .set({
      'timesAvailable': _timesAvailable,
    }, SetOptions(merge: true));
  }

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
                Switch(
                  value: _timesAvailable[index],
                  activeColor: getColor(context),
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
        Row(
          children: [
            Text('Lock:'),
            Switch(
              value: _lockToggle,
              onChanged: (value) {
                _toggleLock();
              },
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getColor(context), // change the color here
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
