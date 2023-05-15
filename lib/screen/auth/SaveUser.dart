import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userId = FirebaseAuth.instance.currentUser!.uid;

Future<void> saveUser(
  String email,
  String fullname,
  String username,
  String age,
  String phoneNumber,
  String userType,
  int num,
) async {
  final firestore = FirebaseFirestore.instance;

  DocumentReference userRef;
  String generatedId; // Declare the variable here

  if (userType == 'Patient') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phoneNumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'coin': 0,
      'pid': userId,
    };

    userRef = await firestore.collection('Patient').add(userData);
    generatedId = userRef.id; // Assign the value here for Patient
  } else if (userType == 'Nutritionist') {
    Map<String, dynamic> userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'phoneNumber': phoneNumber,
      'joinDate': DateTime.now(),
      'registrationProgress': num,
      'nid': userId,
    };

    userRef = await firestore.collection('Nutritionist').add(userData);
    generatedId = userRef.id; // Assign the value here for Nutritionist
  }

  // Use the generatedId value for further operations or assignments if needed
}

Future<void> saveNutritionistAdditionalDetail(
  String address,
  String specialization,
  String customSpecialization,
  String workExperience,
  String gender,
  int num,
) async {
  String generatedId = FirebaseAuth.instance.currentUser!.uid;

  Map<String, dynamic> userData = {
    'address': address,
    'specialization': specialization,
    'customSpecialization': customSpecialization,
    'workExperience': workExperience,
    'gender': gender,
    'joinDate': DateTime.now(),
    'registrationProgress': num,
  };

  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(generatedId)
      .set(userData, SetOptions(merge: true));
}

Future<void> progressRegistration(int num) async {
  String generatedId = FirebaseAuth.instance.currentUser!.uid;

  Map<String, dynamic> userData = {
    'registrationProgress': num,
  };
  await FirebaseFirestore.instance
      .collection('Nutritionist')
      .doc(generatedId)
      .set(userData, SetOptions(merge: true));
}
