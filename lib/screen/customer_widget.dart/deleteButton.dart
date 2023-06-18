import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/main.dart';

Widget deleteAccount(BuildContext context) {
  return TextButton(
  
    onPressed: () async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Account'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Are you sure you want to delete your account?'),
                const SizedBox(height: 8),
                const Text(
                  'Note that this action cannot be undone. All your data will be lost.',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // Sign out from Firebase Authentication
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final currentId = currentUser?.uid;

                  await FirebaseFirestore.instance
                      .collection('Patient')
                      .doc(currentId)
                      .delete()
                      .then((value) =>
                          {FirebaseAuth.instance.currentUser?.delete()});

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Delete Account, I\'m sure!',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          );
        },
      );
    },
    child: Text(
      'Delete Account',
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Colors.redAccent),
    ),
  );
}