import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

final userId = FirebaseAuth.instance.currentUser!.uid;
// this currentId is used to put current User ID
String currentId = '';

String generateNewUserId() {
  final random = Random();
  const int userIdLength = 25;
  const String validChars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String newUserId = '';

  for (int i = 0; i < userIdLength; i++) {
    final randomIndex = random.nextInt(validChars.length);
    newUserId += validChars[randomIndex];
  }

  return newUserId;
}

Future<void> saveUser(String email, String fullname, String username,
    String age, String phonenumber, String userType, int num) async {
  final firestore = FirebaseFirestore.instance;

  DocumentSnapshot userSnapshot;
  bool userIdExists = false;
  currentId = userId;

  if (userType == 'Patient') {
    userSnapshot = await firestore.collection('Patient').doc(currentId).get();
    userIdExists = userSnapshot.exists;
  } else if (userType == 'Nutritionist') {
    userSnapshot =
        await firestore.collection('Nutritionist').doc(currentId).get();
    userIdExists = userSnapshot.exists;
  }

  if (userIdExists) {
    // User with userId already exists, create another one
    currentId = generateNewUserId(); // Generate a new userId here
  }

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
      'pid': currentId,
    };

    await firestore.collection('Patient').doc(currentId).set(userData);
  } else if (userType == 'Nutritionist') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phonenumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'nid': currentId,
    };

    await firestore.collection('Nutritionist').doc(currentId).set(userData);
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
      .doc(currentId)
      .set(userData, SetOptions(merge: true));
}

Future<void> progressRegistration(int num) async {
  Map<String, dynamic> userData = {
    'registrationProgress': num,
  };
  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(currentId)
      .set(userData, SetOptions(merge: true));
}
