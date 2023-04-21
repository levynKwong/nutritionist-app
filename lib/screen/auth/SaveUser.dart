import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveUser(String fullname, String username, String email,
    String age, String phonenumber, String userType) async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;

  Map<String, dynamic> userData = {
    'fullname': fullname,
    'username': username,
    'email': email,
    'age': age,
    'phoneNumber': phonenumber,
  };

  if (userType == 'Patient') {
    userData['coin'] = 0;
  }

  await FirebaseFirestore.instance.collection(userType).doc(uid).set(userData);
}
