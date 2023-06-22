import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Reset your password'),
        
      ),
      body: Container(
        
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width_ * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height_ * 0.15),
                  Text(
                    "Enter the email address associated \n\ with your account",
                    style: TextStyle(
                      fontSize: width_ * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: height_ * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // Add other decoration properties as needed
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: height_ * 0.02),
                            ),
                            validator: (email) {
                              if (email != null &&
                                  !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                      .hasMatch(email)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.07),
                  SizedBox(
                    width: double.infinity,
                    height: height_ * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        resetPassword();
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: width_ * 0.05,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: getColor(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height_ * 0.07),
                  Text(
                    "Make sure that when you reset a new password, it must be at least 6 characters long else it will you give you permission to login. ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 205, 57, 57),
                      fontSize: width_ * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Password reset email has been sent, make sure to put at least 6 characters.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred while resetting password or Password Blank.'),
        ),
      );
    }
  }
}
