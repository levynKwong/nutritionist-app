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
                Text1(
                  text: 'Verify your email',
                ),
                SizedBox(height: height_ * 0.02),
                Text2(text: 'A 6-digit code has been sent to \n\ $email'),
                SizedBox(height: height_ * 0.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (RegisterScreen()),
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
                InputBox(),
                SizedBox(height: height_ * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text2(text: 'Didn\’t\ receive any code?'),
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
                verifyButton(height_, width_, () {
                  // Your code to handle button press goes here
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(double height_, double width_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.13, left: width_ * 0.1, right: width_ * 0.1),
      child: Image.asset('images/email_verification.png'),
    );
  }

  Widget InputBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 40,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Color.fromARGB(255, 211, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget verifyButton(double height_, double width_, VoidCallback onPressed) {
    return Container(
      width: width_ * 0.8,
      height: height_ * 0.07,
      decoration: BoxDecoration(
        color: Color(0xFF989efd),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            'Verify',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
