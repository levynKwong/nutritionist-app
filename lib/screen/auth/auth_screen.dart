import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';
import 'package:meal_aware/screen/home/doctor_forum.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String error = "";

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
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -130,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(0, 81, 100, 153),
                      Color(0xFFe884d0),
                    ],
                    radius: 1,
                    center: Alignment(1, -1),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color(0xFF9553ac),
                    ],
                    radius: 1,
                    center: Alignment(-1, 1),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top + kToolbarHeight,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'WELCOME,',
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 255, 255, 255), // The color of the text
                            fontSize: 30.0, // The size of the text
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'MeA',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'MealAware Company Ltd',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 55.0),
                  SizedBox(
                    height: 500,
                    width: 370,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Color.fromARGB(255, 136, 136, 136),
                            //   width: 3.0,
                            // ),
                            color: Color.fromARGB(183, 214, 228, 239),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 207, 207, 207)
                                    .withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5.0),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'To your account to continue',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Form(
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
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: passwordController,
                                      autofocus: false,
                                      obscureText: true,
                                      onSaved: (newValue) {
                                        passwordController.text = newValue!;
                                      },
                                      validator: (value) {
                                        RegExp regex = RegExp(r'^.{8,32}$');
                                        if (value!.isEmpty) {
                                          return 'Password is required for login';
                                        } else if (!regex.hasMatch(value)) {
                                          return 'Password must be between 8 and 32 characters';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    TextButton(
                                      onPressed: () {
                                        // Handle the tap event.
                                      },
                                      child: Text(
                                        'forgot password?',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              Color.fromARGB(255, 199, 53, 43),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                  SizedBox(width: 40.0),
                                  Icon(
                                    Icons.female,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                  SizedBox(width: 40.0),
                                  Icon(
                                    Icons.transgender,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: (MediaQuery.of(context).size.width / 2) - 45,
                          child: GestureDetector(
                            onTap: () {
                              login(emailController.text,
                                  passwordController.text);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
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
                      'or Sign Up with',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 25, 25),
                        fontSize: 20.0,
                      ),
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

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (credential.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DoctorForum()),
              (_) => false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          setState(() {
            _isLoading = false;
            error = "Invalid Email or Password";
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                error = "";
              });
            });
          });
        }
      }
    }
  }
}
