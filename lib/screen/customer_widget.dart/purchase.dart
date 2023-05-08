import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Deduct 1 coin from the current user's account and create a new payment document
void deductCoin(
  BuildContext context,
  String nutritionistId,
) async {
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
          "uid": userId,
          "nutritionistId": nutritionistId,
          "amount": 1,
          "date": DateTime.now(),
          "status": 1,
        });
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Insufficient coins'),
          duration: Duration(seconds: 3),
        ));
      }
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Coin deducted and payment completed successfully'),
        duration: Duration(seconds: 3),
      ));
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
