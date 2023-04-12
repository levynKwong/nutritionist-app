import 'package:flutter/material.dart';

class EmailVerificationCode extends StatelessWidget {
  const EmailVerificationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // Set scaffold's background color to transparent
        body: Container(
          // Wrap the body in a container to add a gradient background
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5e8eea),
                Color.fromARGB(255, 214, 225, 249),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ));
  }
}
