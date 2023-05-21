import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';

Future<int> getTotalAmount() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('payments')
      .where('pid', isEqualTo: currentId)
      .get();

  int totalAmount = 0;

  querySnapshot.docs.forEach((doc) {
    int amount = doc.get('amount');
    totalAmount += amount;
  });

  return totalAmount;
}

Future<int> getTotalAmountAppointment() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('paymentAppointment')
      .where('pid', isEqualTo: currentId)
      .get();

  int totalAmount = 0;

  querySnapshot.docs.forEach((doc) {
    int amount = doc.get('amount');
    totalAmount += amount;
  });

  return totalAmount;
}
