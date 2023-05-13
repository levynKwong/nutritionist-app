import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_aware/screen/UserIdNutritionistId/userIdNutritionistid.dart';

Future<void> saveUser(String fullname, String username, String email,
    String age, String phonenumber, String userType, int num) async {
  Map<String, dynamic> userData = {
    'email': email,
    'fullname': fullname,
    'username': username,
    'age': age,
    'phoneNumber': phonenumber,
    'joinDate': DateTime.now(),
    'registrationProgress': num,
  };

  if (userType == 'Patient') {
    userData['coin'] = 0;
  }

  await FirebaseFirestore.instance
      .collection(userType)
      .doc(userId)
      .set(userData);
}

Future<void> saveNutritionist(
    String fullname,
    String username,
    String email,
    String age,
    String phonenumber,
    String userType,
    String address,
    String specialization,
    String customSpecialization,
    String workExperience,
    String gender,
    int num) async {
  Map<String, dynamic> userData = {
    'fullname': fullname,
    'username': username,
    'email': email,
    'age': age,
    'phoneNumber': phonenumber,
    'address': address,
    'specialization': specialization,
    'customSpecialization': customSpecialization,
    'gender': gender,
    'joinDate': DateTime.now(),
    'registrationProgress': num,
  };

  await FirebaseFirestore.instance
      .collection(userType)
      .doc(nutritionistId)
      .set(userData);
}
