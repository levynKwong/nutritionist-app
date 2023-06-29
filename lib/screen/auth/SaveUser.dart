import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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

  final userId = FirebaseAuth.instance.currentUser!.uid;

  DocumentSnapshot userSnapshot;
  bool userIdExists = false;
  String currentId1 = userId;

  if (userType == 'Patient') {
    userSnapshot = await firestore.collection('Patient').doc(currentId1).get();
    userIdExists = userSnapshot.exists;
  } else if (userType == 'Nutritionist') {
    userSnapshot =
        await firestore.collection('Nutritionist').doc(currentId1).get();
    userIdExists = userSnapshot.exists;
  }

  if (userIdExists) {
    // User with userId already exists, create another one
    currentId1 = generateNewUserId(); // Generate a new userId here
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
      'pid': currentId1,
      'image_url':
          'https://firebasestorage.googleapis.com/v0/b/meal-aware.appspot.com/o/profile_images%2FOIB.png?alt=media&token=1ec9ec55-79d2-4861-a75c-c5abe9c8118c',
    };
   
      currentId = currentId1;
    
    await firestore.collection('Patient').doc(currentId1).set(userData);
  } else if (userType == 'Nutritionist') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phonenumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'nid': currentId1,
      'image_url':
          'https://firebasestorage.googleapis.com/v0/b/meal-aware.appspot.com/o/profile_images%2FOIB.png?alt=media&token=1ec9ec55-79d2-4861-a75c-c5abe9c8118c',
      'questions': [],
      'lockToggle': true,
    };
    currentId = currentId1;
    await firestore.collection('Nutritionist').doc(currentId1).set(userData);
  }
}

Future<void> saveNutritionistAdditionalDetail(
    String address,
    String specialization,
    String customSpecialization,
    String workExperience,
    String gender,
    int num,
    String currentId) async {
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

Future<void> progressRegistration(int num, String currentId) async {
  Map<String, dynamic> userData = {
    'registrationProgress': num,
  };
  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(currentId)
      .set(userData, SetOptions(merge: true));
}