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
      'image_url':
          'https://firebasestorage.googleapis.com/v0/b/meal-aware.appspot.com/o/profile_images%2FOIB.png?alt=media&token=618d841d-2a15-4c07-89a4-067efefd6953&_gl=1*1gtfbco*_ga*MjAyNjg2MDcxMi4xNjg1ODcxNTIy*_ga_CW55HF8NVT*MTY4NjA3NjQ5NS4xMC4xLjE2ODYwNzk5NzguMC4wLjA.',
      'questions': [],
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
      'editForm': "",
      'patientForm': "",
      'image_url':
          'https://firebasestorage.googleapis.com/v0/b/meal-aware.appspot.com/o/profile_images%2FOIB.png?alt=media&token=618d841d-2a15-4c07-89a4-067efefd6953&_gl=1*1gtfbco*_ga*MjAyNjg2MDcxMi4xNjg1ODcxNTIy*_ga_CW55HF8NVT*MTY4NjA3NjQ5NS4xMC4xLjE2ODYwNzk5NzguMC4wLjA.',
      'questions': [],
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
    'moreInfo': [],
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
