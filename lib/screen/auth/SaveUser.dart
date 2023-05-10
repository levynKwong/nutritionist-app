import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';

Future<void> saveUser(String fullname, String username, String email,
    String age, String phonenumber, String userType) async {
  Map<String, dynamic> userData = {
    'fullname': fullname,
    'username': username,
    'email': email,
    'age': age,
    'phoneNumber': phonenumber,
    'joinDate': DateTime.now(),
    'uid': userId,
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
    String gender) async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;

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
    'uid': uid,
  };

  if (userType == 'Patient') {
    userData['coin'] = 0;
  }

  await FirebaseFirestore.instance.collection(userType).doc(uid).set(userData);
}
