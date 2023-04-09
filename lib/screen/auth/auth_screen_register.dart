import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';
import 'package:meal_aware/screen/auth/auth_parent.dart';
import 'package:meal_aware/screen/home/doctor_forum.dart';

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
  String? _selectedGender;
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
                  const SizedBox(height: 45.0),
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
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 620,
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
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 5.0),
                                    Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Create an account to continue',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Patient | Nutritionist',
                                        prefixIcon: Icon(Icons.account_circle),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedUserType,
                                      items: [
                                        DropdownMenuItem(
                                          value: 'P',
                                          child: Text('Patient'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'N',
                                          child: Text('Nutritionist'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedUserType = newValue;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20.0),
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
                                        }
                                        setState(() {
                                          _selectedAge = newValue;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: fullnameController,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Gender',
                                        prefixIcon: Icon(Icons.person_pin),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedGender,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Male'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Female'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Non-Binary'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedGender = newValue;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: phonenumberController,
                                      decoration: InputDecoration(
                                        labelText: 'PhoneNumber',
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: confirmpasswordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'By pressing "submit" you agree to our',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15.0,
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
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: (MediaQuery.of(context).size.width / 2) - 45,
                            child: GestureDetector(
                              onTap: () {
                                register(
                                  _selectedUserType!,
                                  fullnameController.text,
                                  usernameController.text,
                                  _selectedGender!,
                                  emailController.text,
                                  _selectedAge!,
                                  phonenumberController.text,
                                  passwordController.text,
                                );
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
                  ),
                  const SizedBox(height: 15.0),
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
                      'or back to Sign In',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register(
      String usertype,
      String fullname,
      String username,
      String gender,
      String email,
      String age,
      String phonenumber,
      String password) async {
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
                  saveUser(usertype, fullname, username, gender, email, age,
                      phonenumber),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorForum()),
                      (_) => false),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _isLoading = false;
            error = 'The password provided is too weak.';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _isLoading = false;
            error = 'The account already exists for that email.';
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          error = "An unexpected error occured, please try again";
        });
      }
    }
  }

  void saveUser(String usertype, String fullname, String username,
      String gender, String email, String age, String phonenumber) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    await FirebaseFirestore.instance
        .collection(_selectedUserType!)
        .doc(uid)
        .set({
      'user type': _selectedUserType!,
      'fullname': fullname,
      'username': username,
      'email': email,
      'age': age,
      'phone number': phonenumber,
    });
  }
}
