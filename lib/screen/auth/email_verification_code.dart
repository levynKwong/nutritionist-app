import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';
import 'package:meal_aware/screen/auth/term_and_condition.dart';

class EmailVerificationCode extends StatefulWidget {
  final String email;
  final String fullname;
  final String username;
  final String age;
  final String phonenumber;
  final String userType;

  EmailVerificationCode({
    Key? key,
    required this.email,
    required this.fullname,
    required this.username,
    required this.age,
    required this.phonenumber,
    required this.userType,
  }) : super(key: key);

  @override
  _EmailVerificationCodeState createState() => _EmailVerificationCodeState();
}

class _EmailVerificationCodeState extends State<EmailVerificationCode> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // check if the user is logged in
    if (FirebaseAuth.instance.currentUser != null) {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();
      }
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    isEmailVerified = user.emailVerified;
    if (isEmailVerified) {
      timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email confirmed'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Terms_and_condition(),
        ),
      );
      saveUser(
        widget.fullname,
        widget.username,
        widget.email,
        widget.age,
        widget.phonenumber,
        widget.userType,
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
      print('Email verification sent');
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified == true) {
      return Terms_and_condition();
    } else {
      return _emailVerification(context);
    }
  }

  Widget _buildImage(double height_, double width_) {
    return Container(
      margin: EdgeInsets.only(
        top: height_ * 0.13,
        left: width_ * 0.1,
        right: width_ * 0.1,
      ),
      child: Image.asset('images/email_verification.png'),
    );
  }

  Widget _emailVerification(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          background(),
          _buildImage(height_, width_),
          Positioned(
            left: 0,
            right: 0,
            top: height_ * 0.42,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text1(text: 'Verify your email'),
                SizedBox(height: height_ * 0.02),
                Text2(
                  text: 'An email from us has been sent to \n\ ${widget.email}',
                ),
                SizedBox(height: height_ * 0.02),

                // InputBox(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text2(text: 'Didn’t receive any email?'),
                    TextButton(
                      onPressed: () {
                        if (canResendEmail == true) {
                          sendVerificationEmail();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Verification email has been resent'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height_ * 0.02),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
