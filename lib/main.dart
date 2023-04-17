import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_aware/screen/auth/auth_parent.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';
import 'package:meal_aware/screen/auth/term_and_condition.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/auth/email_verification_code.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/customer_widget.dart/token_top_right.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

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
      home: AuthScreen(),
      // home: const ParentAuth(),
      // home: Terms_and_condition()
      // home: Home(),
      // home: token_top(),
      // home: test_home(),
      // home: DoctorForum(),
      // home: NotificationWidget(),
      // home: EmailVerificationCode(
      //   email: '',
      // ),
    );
  }
}
