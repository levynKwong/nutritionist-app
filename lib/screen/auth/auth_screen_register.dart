import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';
import 'package:meal_aware/screen/auth/auth_parent.dart';
import 'package:meal_aware/screen/auth/nutritionistAdditionalDetail.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/auth/email_verification_code.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  Container(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'MeA',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: MediaQuery.of(context).size.width * 0.20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    'MealAware Company Ltd',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
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
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.001),
                                    Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.009),
                                    Text(
                                      'Create an account to continue',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Patient | Nutritionist',
                                        prefixIcon: Icon(Icons.account_circle),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedUserType,
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Patient',
                                          child: Text('Patient'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Nutritionist',
                                          child: Text('Nutritionist'),
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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Age Range',
                                        prefixIcon: Icon(Icons.date_range),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedAge,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('1-18'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('19-50'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('50+'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        // Do something with the new value
                                        if (newValue == '1') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ParentAuth()),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'You are under 18. you need to have a parent or a guardian to register you.'),
                                              duration: Duration(seconds: 4),
                                            ),
                                          );
                                        }

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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextFormField(
                                      controller: fullnameController,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextFormField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please enter a username");
                                        }
                                        // reg expression for email validation
                                        if (!RegExp(
                                                "^(?=.{3,8})(?![_.])(?!.*[_.]{2})[a-zA-Z0-9_]+(?<![_.])")
                                            .hasMatch(value)) {
                                          return ("Please Enter a valid username (3 to 8 Characters)");
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
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
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return ("Please Enter a valid email");
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextFormField(
                                      controller: phonenumberController,
                                      decoration: InputDecoration(
                                        labelText: 'PhoneNumber',
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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
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
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      'By pressing "submit" you agree to our',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //  Handle the tap event.
                                      },
                                      child: Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 20, 20),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.male,
                                          color: Colors.grey,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        Icon(
                                          Icons.female,
                                          color: Colors.grey,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        Icon(
                                          Icons.transgender,
                                          color: Colors.grey,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    register(
                                      fullnameController.text,
                                      usernameController.text,
                                      emailController.text,
                                      _selectedAge ?? '',
                                      phonenumberController.text,
                                      passwordController.text,
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: MediaQuery.of(context).size.width *
                                        0.12,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (AuthScreen()),
                        ),
                      );
                    },
                    child: Text(
                      'or back to login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
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

  void register(String fullname, String username, String email, String age,
      String phonenumber, String password) async {
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
                  saveUser(fullname, username, email, age, phonenumber),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorForum()),
                      (_) => false),
                  if (_selectedUserType == 'Nutritionist')
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => nutritionistAdditionalDetail(),
                        ),
                      ),
                    }
                  else if (_selectedUserType == 'Patient')
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmailVerificationCode(email: email),
                        ),
                      ),
                    }
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

  void saveUser(String fullname, String username, String email, String age,
      String phonenumber) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    Map<String, dynamic> userData = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'age': age,
      'phoneNumber': phonenumber,
    };

    if (_selectedUserType == 'Patient') {
      userData['coin'] = 0;
    }

    await FirebaseFirestore.instance
        .collection(_selectedUserType!)
        .doc(uid)
        .set(userData);
  }
}
