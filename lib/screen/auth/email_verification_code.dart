import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
import 'package:meal_aware/screen/customer_widget.dart/text2.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';
import 'package:meal_aware/screen/home/doctor_forum.dart';

class EmailVerificationCode extends StatefulWidget {
  final String email;
  EmailVerificationCode({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationCodeState createState() => _EmailVerificationCodeState();
}

class _EmailVerificationCodeState extends State<EmailVerificationCode> {
  bool isEmailVerified = false;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? DoctorForum() : _emailVerification(context);
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Change email',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(height: height_ * 0.02),
                // InputBox(),
                SizedBox(height: height_ * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text2(text: 'Didn’t receive any email?'),
                    TextButton(
                      onPressed: () {
                        // Resend code action
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
