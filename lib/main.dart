import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_aware/screen/auth/login/login.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();
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
      // home: PatientAdditionalDetail(),
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
