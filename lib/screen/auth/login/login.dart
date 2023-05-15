import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/auth/login/forgotPassword/forgotPassword.dart';

import 'package:meal_aware/screen/auth/registration/auth_screen_register.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/confirmationNutritionist.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/nutritionistAdditionalDetail.dart';
import 'package:meal_aware/screen/auth/registration/patientConfimation/email_verification_code.dart';

import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';

class Login extends StatefulWidget {
  Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String error = "";

  @override
  void initState() {
    super.initState();
    // Initialize _formKey here
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background_login.png'),
                fit: BoxFit.contain,
                alignment: Alignment(0, -0.45),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: height_ * 0.05),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Text(
                        'MeA',
                        style: TextStyle(
                          color: Color.fromARGB(255, 99, 144, 228),
                          fontSize: width_ * 0.20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'MealAware Company Ltd',
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 164, 231),
                          fontSize: width_ * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height_ * 0.05),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("images/doctor_holdingPhone.png"),
                              fit: BoxFit.contain,
                              alignment: Alignment(0, -1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height_ * 0.01),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: width_ * 0.08,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // add additional widgets here if needed
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height_ * 0.015),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                width_ * 0.08, 0, width_ * 0.08, 0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (newValue) {
                                      emailController.text = newValue!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Email';
                                      }
                                      if (!RegExp(
                                              '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  TextFormField(
                                    controller: passwordController,
                                    autofocus: false,
                                    obscureText: true,
                                    onSaved: (newValue) {
                                      passwordController.text = newValue!;
                                    },
                                    validator: (value) {
                                      RegExp regex = RegExp(r'^.{6,32}$');
                                      if (value!.isEmpty) {
                                        return 'Password is required for login';
                                      } else if (!regex.hasMatch(value)) {
                                        return 'Password must be between 6 and 32 characters';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.01),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (ForgotPasswordScreen()),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'forgot password?',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      login(emailController.text,
                                          passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          getColor(), // sets the background color of the button
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: height_ * 0.06,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: width_ * 0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.01),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (RegisterScreen()),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'or Sign Up with',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 25, 25),
                                        fontSize: width_ * 0.040,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading..."),
                  ],
                ),
              );
            },
          );
        });
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (credential.user != null) {
          final patientDoc = await FirebaseFirestore.instance
              .collection('Patient')
              .doc(credential.user!.uid)
              .get();
          final nutritionistDoc = await FirebaseFirestore.instance
              .collection('Nutritionist')
              .doc(credential.user!.uid)
              .get();
          if (patientDoc.exists) {
            final registrationProgress =
                patientDoc.data()?['registrationProgress'] ?? 0;
            final pid = patientDoc.data()?['pid'];
            final uid = credential.user!.uid;
            currentId = pid ?? uid;
            // Redirect to the patient screen
            if (registrationProgress == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => EmailVerificationCode(email: email)),
                (_) => false,
              );
            } else if (registrationProgress == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (_) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('There is an error that occurred'),
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          } else if (nutritionistDoc.exists) {
            final NutritionistRegistrationProgress =
                nutritionistDoc.data()?['registrationProgress'] ?? 0;
            final nid = nutritionistDoc.data()?['nid'];
            final uid = credential.user!.uid;
            currentId = nid ?? uid;
            if (NutritionistRegistrationProgress == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => NutritionistAdditionalDetail()),
                (_) => false,
              );
            } else if (NutritionistRegistrationProgress == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => confirmationNutritionist()),
                (_) => false,
              );
            } else if (NutritionistRegistrationProgress == 2) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NutritionistHome()),
                (_) => false,
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You are not authorized to access this app'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Email or Password'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Something went wrong'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Dismiss the dialog
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
}
