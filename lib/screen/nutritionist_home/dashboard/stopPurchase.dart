import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

class StopPurchase extends StatefulWidget {
  final String userId;

  StopPurchase({required this.userId});

  @override
  _StopPurchaseState createState() => _StopPurchaseState();
}

class _StopPurchaseState extends State<StopPurchase> {
  bool _loading = true;
  bool _lockToggle = false;

  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchFirestoreLock();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchFirestoreLock() {
    FirebaseFirestore.instance
        .collection('stopPurchaseToggle')
        .doc('stopPurchaseId')
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data.containsKey('stopPurchase')) {
          setState(() {
            _lockToggle = data['stopPurchase'];
          });
        }
      }
      setState(() {
        _loading = false;
      });
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      print('Error retrieving lock status: $error');
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
        .collection('stopPurchaseToggle')
        .doc('stopPurchaseId')
        .set(
      {
        'stopPurchase': _lockToggle,
      },
      SetOptions(merge: true),
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
                  'Lock all purchases',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height_ * 0.01,
                ),
                Text(
                  'This is to prevent any purchases from being made. Patients will be unable to purchase any coins. Make sure you do not enable this by accident.\n\n Enable it when you are available to welcome new patients on the platform.\n\n if the slider is on the right, it means it is locked.',
                  style: TextStyle(fontSize: width_ * 0.05, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
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
