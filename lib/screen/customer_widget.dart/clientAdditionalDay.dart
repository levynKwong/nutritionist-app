import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Deduct 1 coin from the current user's account and create a new payment document
void clientAdditionalDay(BuildContext context, String friendUid) async {
  User? user = _auth.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference userRef = _firestore.collection("Patient").doc(friendUid);
    DocumentReference paymentRef = _firestore.collection("payments").doc();

    // Use a transaction to ensure atomic updates
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userRef);

      // Deduct 1 coin from the user's account

      // Create a new payment document in the "payments" collection
      transaction.set(paymentRef, {
        "pid": friendUid,
        "nid": userId,
        "amount": 0,
        "date": DateTime.now(),
        "status": 1,
        "progress": 1,
      });
      // Update the "ClientCounter" field in the "Nutritionist" collection

// Get the values of the "ClientCounter" and "selectedNumber" fields

// If the "ClientCounter" and "selectedNumber" fields are the same, toggle the "lockToggle" field to true
    }).then((value) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Additional day given to client'),
        duration: Duration(seconds: 3),
      ));

      print('Additional day given to client');
      NotificationService.showNotification(
        title: 'Additional day given ',
        body: 'Additional day given to client.',
      );
      // Show the notification
    }).catchError((error) {
      // Failed to deduct coin, create payment document, or update ClientCounter
      print("Failed to give additional day given to client. $error");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Failed to deduct coin, create payment document, or update ClientCounter: $error'),
      //   duration: Duration(seconds: 3),
      // ));
    });
  }
}
