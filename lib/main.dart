import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_aware/screen/auth/introduction/introduction_nutritionist.dart';
import 'package:meal_aware/screen/auth/introduction/introduction_patient.dart';
import 'package:meal_aware/screen/auth/login/login.dart';

import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/logo',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: RegisterScreen(),
      home: Login(),
      // home: introductionNutritionist(),
      // home: introductionPatient(),
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
