import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Deduct 1 coin from the current user's account
void deductCoin(BuildContext context, String nutritionistId) async {
  User? user = _auth.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference userRef = _firestore.collection("Patient").doc(userId);

    // Use a transaction to ensure atomic updates
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userRef);
      int coins = snapshot.get("coin") ?? 0;
      if (coins >= 1) {
        transaction.update(userRef, {"coin": coins - 1});
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Insufficient coins'),
          duration: Duration(seconds: 3),
        ));
      }
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Coin deducted successfully'),
        duration: Duration(seconds: 3),
      ));
    }).catchError((error) {
      // Failed to deduct coin
      print("Failed to deduct coin: $error");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Failed to deduct coin: $error'),
      //   duration: Duration(seconds: 3),
      // ));
    });
  }
}
