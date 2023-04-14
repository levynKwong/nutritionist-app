import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_aware/screen/auth/auth_parent.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';
import 'package:meal_aware/screen/auth/term_and_condition.dart';
import 'package:meal_aware/screen/home/home.dart';
import 'package:meal_aware/screen/home/doctor_forum.dart';
import 'package:meal_aware/screen/auth/email_verification_code.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
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
      // home: const Terms_and_condition()
      // home: test_home(),
      // home: DoctorForum(),
      // home: EmailVerificationCode(
      //   email: '',
      // ),
    );
  }
}
