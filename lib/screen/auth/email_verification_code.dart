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
          _buildImage(),
          text1(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.only(top: 200, left: 25, right: 25),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/email_verification.png'),
        ),
      ),
    );
  }
}
