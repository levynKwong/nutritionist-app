import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

class EmailVerificationCode extends StatelessWidget {
  const EmailVerificationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          background(),
          Align(
            alignment: Alignment.topCenter,
            child: _buildImage(height_),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: height_ * 0.1),
              child: Text1(text: 'Verify your email'),
            ),
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
