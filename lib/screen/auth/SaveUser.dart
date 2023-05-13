// import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// String _userId = '';

// String get userId => _userId;

// set userId(String value) {
//   _userId = value;
// }
var userId = FirebaseAuth.instance.currentUser!.uid;

Future<void> saveUser(String email, String fullname, String username,
    String age, String phonenumber, String userType, int num) async {
  final firestore = FirebaseFirestore.instance;

  // bool idsAreEqual;

  if (userType == 'Patient') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phonenumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'coin': 0,
      'pid': userId,
    };

    await firestore.collection('Patient').doc(userId).set(userData);
  } else if (userType == 'Nutritionist') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phonenumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'nid': userId,
    };

    await firestore.collection('Nutritionist').doc(userId).set(userData);
  }
}

Future<void> saveNutritionistAdditionalDetail(
    String address,
    String specialization,
    String customSpecialization,
    String workExperience,
    String gender,
    int num) async {
  Map<String, dynamic> userData = {
    'address': address,
    'specialization': specialization,
    'customSpecialization': customSpecialization,
    'gender': gender,
    'joinDate': DateTime.now(),
    'registrationProgress': num,
  };

  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(userId)
      .set(userData, SetOptions(merge: true));
}

Future<void> progressRegistration(int num) async {
  Map<String, dynamic> userData = {
    'registrationProgress': num,
  };
  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(userId)
      .set(userData, SetOptions(merge: true));
}
