import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/text2.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';

class EmailVerificationCode extends StatelessWidget {
  final String email;
  const EmailVerificationCode({Key? key, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          background(),
          Align(
            alignment: Alignment.topCenter,
            child: _buildImage(height_),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: height_ * 0.03),
                child: Text1(
                  text: 'Verify your email',
                ),
              ),
              Text2(text: 'A 6-digit code has been sent to \n\ $email'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.1),
      child: Image.asset('images/email_verification.png'),
    );
  }
}
