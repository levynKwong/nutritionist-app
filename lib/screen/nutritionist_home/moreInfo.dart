import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void moreInfo(BuildContext context, String friendUid) async {
  final patientSnapshot = await FirebaseFirestore.instance
      .collection('Patient')
      .where('pid', isEqualTo: friendUid)
      .limit(1)
      .get();
  if (patientSnapshot.docs.isNotEmpty) {
    final patientData = patientSnapshot.docs.first.data();
    final username = patientData['username'];
    final fullname = patientData['fullname'];
    final email = patientData['email'];
    var age = patientData['age'];
    final phoneNumber = patientData['phoneNumber'];

    // Check the value of the specialization field and assign a human-readable label
    if (age == '1') {
      age = '1111';
    } else if (age == '2') {
      age = '1111';
    } else if (age == '3') {
      age = '1111';
    } else if (age == '4') {
      age = '11111';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('More Info'),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Username: $username'),
                Text(''),
                Text('Fullname: $fullname'),
                Text(''),
                Text('Email: $email'),
                Text(''),
                Text('Phone: $phoneNumber'),
                Text(''),
                Text('Age: $age'),
                Text(''),
                Text('Height: '),
                Text(''),
                Text('Gender: '),
                Text(''),
                Text('CurrentBody Weight: '),
                Text(''),
                Text('Number of meal per day: '),
                Text(''),
                Text('Body goal: '),
                Text(''),
                Text('Activity level: '),
                Text(''),
                Text('Dietary Preference or restriction: '),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
