import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_aware/screen/auth/login/login.dart';
import 'package:meal_aware/screen/auth/registration/patientConfimation/email_verification_code.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/confirmationNutritionist.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/nutritionistAdditionalDetail.dart';
import 'package:meal_aware/screen/auth/term_and_condition.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/NutritionistChat.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/auth/registration/patientConfimation/email_verification_code.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/BookAppointment.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/NutritionistBookApp.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/ChatDoctor.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/GetCoin.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

import 'screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'screen/home/Doctor_forum/BookAppointment/paymentAppointment.dart';
import 'screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/paymentChat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: RegisterScreen(),
      home: Login(),
      // home: ChatScreen('2345254','test'),
      // home: NutritionistHome(),
      // home: const ParentAuth(),
      // home: Terms_and_condition()
      // home: Home(),
      // home: BookAppointmentService(),
      // home: NutritionistBookAppointment(),
      // home: NutritionistChat()
      // home: ChatDoctorReg(),
      // home: token_top(),
      // home: test_home(),
      // home: DoctorForum(),
      // home: NotificationWidget(),
      // home: SelectionDate(),
      // home: paymentAppointment(),
      // home: GetCoin(),
      //     home: paymentChat(
      //   nutritionistId: '',
      //   nutritionistName: '',
      // )
      // home: EmailVerificationCode(
      //   email: '',
      //   age: '',
      //   fullname: '',
      //   phonenumber: '',
      //   userType: '',
      //   username: '',
      // ),
      // home: NutritionistAdditionalDetail(
      //     email: '',
      //     fullname: '',
      //     username: '',
      //     age: '',
      //     phonenumber: '',
      //     userType: ''),
      //   home: confirmationNutritionist(
      //       email: '',
      //       fullname: '',
      //       username: '',
      //       age: '',
      //       phonenumber: '',
      //       userType: '',
      //       address: '',
      //       specialization: '',
      //       customSpecialization: '',
      //       workExperience: '',
      //       gender: ''),
    );
  }
}
