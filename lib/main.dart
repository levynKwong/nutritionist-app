import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:meal_aware/screen/auth/login/login.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class LocalStorage {
  static const String userIdKey = 'userId';
  static const String emailKey = 'email';

  static Future<void> saveLoginData({
    String? userId,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId ?? '');
    await prefs.setString(emailKey, email ?? '');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
        if (user != null) {
          // Store user's login data locally
          LocalStorage.saveLoginData(
            userId: user.uid,
            email: user.email,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget initialScreen;

    if (_currentUser != null) {
      // User is logged in, check if it is a nutritionist or not
      if (_currentUser!.uid == pid) {
        initialScreen = NutritionistHome();
      } else {
        initialScreen = Home();
      }
    } else {
      // User is not logged in, show the login screen
      initialScreen = Login();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialScreen,
    );
  }
}



      // home: RegisterScreen(),
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