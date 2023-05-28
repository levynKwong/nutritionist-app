import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/main.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/auth/registration/patientConfimation/email_verification_code.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';

class ParentAuth extends StatefulWidget {
  ParentAuth({Key? key}) : super(key: key);

  @override
  _ParentAuthState createState() => _ParentAuthState();
}

class _ParentAuthState extends State<ParentAuth> {
  final _formKey = GlobalKey<FormState>();
  final choiceController = TextEditingController();
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final phonenumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  String error = "";
  bool _isLoading = false;
  String? _selectedUserType;
  String? _selectedAge;
  int num = 0;
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
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
                      SizedBox(height: height_ * 0.01),
                      Text(
                        'MealAware Company Ltd',
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 164, 231),
                          fontSize: width_ * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height_ * 0.02),
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
                                      'Register',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.02),
                                  Text(
                                    'Create an account to continue',
                                    style: TextStyle(
                                      fontSize: width_ * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.02),
                                  Text(
                                    'Since you are under 18, you need to have \n\a parent or a guardian to register you.',
                                    style: TextStyle(
                                      fontSize: width_ * 0.05,
                                      color: Color.fromARGB(255, 197, 51, 40),
                                    ),
                                  ),
                                  // add additional widgets here if needed
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height_ * 0.02),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                width_ * 0.08, 0, width_ * 0.08, 0),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Patient',
                                        prefixIcon: Icon(Icons.account_circle),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedUserType,
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Patient',
                                          child: Text('Patient'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedUserType = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select your user type';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Enter the age of the child',
                                        prefixIcon: Icon(Icons.date_range),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedAge,
                                      items: [
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('13-15'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('16-18'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        // Do something with the new value

                                        setState(() {
                                          _selectedAge = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select your age range';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      controller: fullnameController,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Enter the child\'s\ Full Name',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your full name';
                                        } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                            .hasMatch(value)) {
                                          return 'Please enter a valid name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Enter the child\'s\ Username',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please enter a username");
                                        }
                                        // reg expression for email validation
                                        if (value.length > 8) {
                                          return ("Please enter a valid username (3 to 8 characters)");
                                        } else if (!RegExp(
                                                "^(?=.{3,8})(?![_.])(?!.*[_.]{2})[a-zA-Z0-9_]+(?<![_.])")
                                            .hasMatch(value)) {
                                          return ("Please enter a valid username (3 to 8 characters)");
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please Enter Your Email");
                                        }
                                        // reg expression for email validation
                                        if (!RegExp(
                                                r"^\s*[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+\s*$")
                                            .hasMatch(value)) {
                                          return ("Please Enter a valid email");
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      controller: phonenumberController,
                                      decoration: InputDecoration(
                                        labelText: 'Your PhoneNumber',
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a phone number';
                                        }
                                        if (!RegExp(r'^\+?[0-9]{7,9}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        RegExp regex = new RegExp(r'^.{6,32}$');
                                        if (value!.isEmpty) {
                                          return ("Password is required for registration");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("Enter (6 to 32 Characters) valid password");
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextFormField(
                                      controller: confirmpasswordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please confirm your password");
                                        }
                                        if (value != passwordController.text) {
                                          return ("Passwords do not match");
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height_ * 0.02),
                          Text(
                            'By pressing "submit" you agree to our',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                          SizedBox(height: height_ * 0.01),
                          TermsAndConditionsDialog(),
                          SizedBox(height: height_ * 0.02),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                width_ * 0.08, 0, width_ * 0.08, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                register(
                                    fullnameController.text,
                                    usernameController.text,
                                    emailController.text,
                                    _selectedAge ?? '',
                                    phonenumberController.text,
                                    passwordController.text,
                                    num);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(
                                    0xFF6889c6), // sets the background color of the button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: height_ * 0.06,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: width_ * 0.05,
                                    color: Colors.white,
                                  ),
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
                                  builder: (context) => (Login()),
                                ),
                              );
                            },
                            child: Text(
                              'or back to login',
                              style: TextStyle(
                                color: Color.fromARGB(255, 25, 25, 25),
                                fontSize: width_ * 0.040,
                              ),
                            ),
                          ),
                          SizedBox(height: height_ * 0.02),
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

  void register(String fullname, String username, String email, String age,
      String phonenumber, String password, int num) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((value) => {
                  // saveUser(fullname, username, email, age, phonenumber),

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailVerificationCode(
                        email: email,
                      ),
                    ),
                  ),
                  saveUser(email, fullname, username, age, phonenumber,
                      _selectedUserType!, num),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('The password provided is too weak.'),
                duration: Duration(seconds: 3)));
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('The account already exists for that email.'),
                duration: Duration(seconds: 3)));
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('An unexpected error occurred, please try again'),
              duration: Duration(seconds: 3)));
        });
      }
    }
  }
}
