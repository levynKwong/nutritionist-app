import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Deduct 1 coin from the current user's account and create a new payment document
void deductCoin(BuildContext context, String nid) async {
  User? user = _auth.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference userRef = _firestore.collection("Patient").doc(userId);
    DocumentReference paymentRef = _firestore.collection("payments").doc();

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
          "status": 1,
          "progress": 1,
        });
        // Update the "ClientCounter" field in the "Nutritionist" collection
        DocumentReference nutritionistRef =
            _firestore.collection("Nutritionist").doc(nid);
        transaction.update(nutritionistRef, {
          "ClientCounter": FieldValue.increment(1),
        });

        FirebaseFirestore.instance
            .collection('Nutritionist')
            .doc(
                nid) // Replace 'currentId' with the specific document ID you want to fetch
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
// Get the values of the "ClientCounter" and "selectedNumber" fields
            int clientCounter = documentSnapshot.get("ClientCounter") ?? 0;
            int selectedNumber = documentSnapshot.get("selectedNumber") ?? 0;
            if (clientCounter >= selectedNumber) {
              _firestore
                  .collection("Nutritionist")
                  .doc(nid)
                  .update({"lockToggle": true});
            }
          }
        });

// Get the values of the "ClientCounter" and "selectedNumber" fields

// If the "ClientCounter" and "selectedNumber" fields are the same, toggle the "lockToggle" field to true
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
      // Failed to deduct coin, create payment document, or update ClientCounter
      print(
          "Failed to deduct coin, create payment document, or update ClientCounter: $error");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Failed to deduct coin, create payment document, or update ClientCounter: $error'),
      //   duration: Duration(seconds: 3),
      // ));
    });
  }
}
