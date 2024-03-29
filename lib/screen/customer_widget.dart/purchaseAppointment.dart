import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Deduct 1 coin from the current user's account and create a new payment document
void deductCoinAppoinment(
  BuildContext context,
  String nid,
) async {
  User? user = _auth.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference userRef = _firestore.collection("Patient").doc(userId);
    DocumentReference paymentRef =
        _firestore.collection("paymentAppointment").doc();

    // Use a transaction to ensure atomic updates
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userRef);
      int coins = snapshot.get("coin") ?? 0;
      if (coins >= 1) {
        // Deduct 1 coin from the user's account
        transaction.update(userRef, {"coin": coins - 1});
        // Create a new payment document in the "payments" collection
        transaction.set(paymentRef, {
          "pid": userId,
          "nid": nid,
          "amount": 1,
          "date": DateTime.now(),
        });
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Insufficient coins'),
          duration: Duration(seconds: 3),
        ));
      }
    }).then((value) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Coin deducted and payment completed successfully'),
        duration: Duration(seconds: 3),
      ));

      print('Coin deducted and payment completed successfully');
      NotificationService.showNotification(
        title: 'Payment Successful',
        body: 'You have successfully paid for the nutritionist chat.',
      );
      // Show the notification
    }).catchError((error) {
      // Failed to deduct coin or create payment document
      print("Failed to deduct coin or create payment document: $error");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Failed to deduct coin or create payment document: $error'),
      //   duration: Duration(seconds: 3),
      // ));
    });
  }
}
