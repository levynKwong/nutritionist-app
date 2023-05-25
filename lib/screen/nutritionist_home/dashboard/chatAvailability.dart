import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';

class ChatAvailability extends StatefulWidget {
  final String userId;

  ChatAvailability({required this.userId});

  @override
  _ChatAvailabilityState createState() => _ChatAvailabilityState();
}

class _ChatAvailabilityState extends State<ChatAvailability> {
  int _selectedTimeIndex = -1;
  bool _lockToggle = false;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  void _fetchData() async {
    final document = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(widget.userId)
        .get();

    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      if (data.containsKey('selectedNumber')) {
        setState(() {
          _selectedTimeIndex = data['selectedNumber'];
        });
      }
      if (data.containsKey('lockToggle')) {
        setState(() {
          _lockToggle = data['lockToggle'];
        });
      }
    }

    setState(() {
      _loading = false;
    });
  }

  void _selectTime(int index) {
    setState(() {
      if (_lockToggle) {
        _selectedTimeIndex = -1;
      } else {
        _selectedTimeIndex = _selectedTimeIndex == index ? -1 : index;
      }
    });

    _updateFirestore();
  }

  void _toggleLock() {
    setState(() {
      _lockToggle = !_lockToggle;
      if (_lockToggle) {
        _selectedTimeIndex = -1;
      } else {
        resetClientCounter();
      }
    });

    _updateFirestore();
  }

  void _updateFirestore() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(widget.userId)
        .set({
      'selectedNumber': _selectedTimeIndex,
      'lockToggle': _lockToggle,
    }, SetOptions(merge: true));
    // make a snackbar
  }

  void resetClientCounter() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(widget.userId)
        .update({'ClientCounter': 0});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ClientCounter Reset'),
        duration: Duration(seconds: 3),
      ),
    );
    NotificationService.showNotification(
      title: 'ClientCounter Reset',
      body: 'ClientCounter Reset, Set you Max Client Availability',
    );
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
                  'Maximum Client Availability',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height_ * 0.01,
                ),
                Text(
                  'Select the maximum number of clients you can chat in a day.',
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
            final num = index + 1;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$num'),
                Checkbox(
                  value: _selectedTimeIndex == index,
                  onChanged: (value) {
                    _selectTime(index);
                  },
                ),
              ],
            );
          }).take(10).toList(),
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
