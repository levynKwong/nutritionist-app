import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/confirmationNutritionist.dart';
import 'package:meal_aware/screen/auth/registration/nutritionistConfirmation/redirectEmail.dart';
import 'package:meal_aware/screen/customer_widget.dart/background_2.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

class NutritionistAdditionalDetail extends StatefulWidget {
  final String email, fullname, username, age, phonenumber, userType;
  const NutritionistAdditionalDetail(
      {Key? key,
      required this.email,
      required this.fullname,
      required this.username,
      required this.age,
      required this.phonenumber,
      required this.userType})
      : super(key: key);

  @override
  State<NutritionistAdditionalDetail> createState() =>
      _NutritionistAdditionalDetailState(
          email, fullname, username, age, phonenumber, userType);
}

class _NutritionistAdditionalDetailState
    extends State<NutritionistAdditionalDetail> {
  final _formKey = GlobalKey<FormState>();
  final String email, fullname, username, age, phonenumber, userType;
  _NutritionistAdditionalDetailState(this.email, this.fullname, this.username,
      this.age, this.phonenumber, this.userType);

  String? _selectedSpecialization;
  bool _showCustomSpecializationField = false;
  String? _customSpecialization = '';
  String? experience;
  String? gender;

  final addressController = TextEditingController();

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
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: width_ * 0.16),
                          Text(
                            'MeA',
                            style: TextStyle(
                              color: Color.fromARGB(255, 99, 144, 228),
                              fontSize: width_ * 0.20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                                  Text(
                                    'Additional Details',
                                    style: TextStyle(
                                      fontSize: width_ * 0.04,
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
                                    TextFormField(
                                      controller: addressController,
                                      decoration: InputDecoration(
                                        labelText: 'Address of work',
                                        prefixIcon: Icon(Icons.location_on),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your address of work';
                                        } else if (!RegExp(
                                                r"^[A-Za-z\s]+(?:[-\s][A-Za-z\s]+)*$")
                                            .hasMatch(value)) {
                                          return 'Please enter a valid address';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.025),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Specialization',
                                        prefixIcon: Icon(Icons.local_hospital),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedSpecialization,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Sport Nutritionist'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Pediatric Nutritionist'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Clinical Nutritionist'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('General Nutritionist'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('Other'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSpecialization = newValue;
                                          _showCustomSpecializationField =
                                              newValue == '5';
                                        });
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    if (_selectedSpecialization == '5')
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Other Specialization',
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            _customSpecialization = value;
                                          });
                                        },
                                      ),
                                    SizedBox(height: height_ * 0.006),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Work Experience',
                                        prefixIcon: Icon(Icons.work),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: experience,
                                      items: [
                                        DropdownMenuItem(
                                          value: '6',
                                          child: Text('1-2'),
                                        ),
                                        DropdownMenuItem(
                                          value: '7',
                                          child: Text('3-5'),
                                        ),
                                        DropdownMenuItem(
                                          value: '8',
                                          child: Text('5-10'),
                                        ),
                                        DropdownMenuItem(
                                          value: '9',
                                          child: Text('10+'),
                                        ),
                                      ],
                                      onChanged: (String? Value) {
                                        setState(() {});
                                        experience = Value;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.025),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Gender',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: gender,
                                      items: [
                                        DropdownMenuItem(
                                          value: '10',
                                          child: Text('Male'),
                                        ),
                                        DropdownMenuItem(
                                          value: '11',
                                          child: Text('Female'),
                                        ),
                                        DropdownMenuItem(
                                          value: '12',
                                          child: Text('Non-Binary'),
                                        ),
                                      ],
                                      onChanged: (String? Value) {
                                        setState(() {});
                                        gender = Value;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    TextWithLink(),
                                    SizedBox(height: height_ * 0.02),
                                    TextButton(
                                      onPressed: () {
                                        popUpButton(width_, height_);
                                      },
                                      child: Text(
                                        'Click here to follow instructions, making sure your eligibility',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
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
                          GestureDetector(
                            onTap: () {
                              //  Handle the tap event.
                            },
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: Color.fromARGB(255, 196, 20, 20),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: height_ * 0.02),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                width_ * 0.08, 0, width_ * 0.08, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                confirmationNutritionist(
                                  email: email,
                                  fullname: fullname,
                                  username: username,
                                  age: age,
                                  phonenumber: phonenumber,
                                  userType: userType,
                                  address: addressController.text,
                                  specialization: _selectedSpecialization!,
                                  customSpecialization: _customSpecialization!,
                                  workExperience: experience!,
                                  gender: gender!,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(
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

  Future<dynamic> popUpButton(double width_, double height_) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("make sure you follow this instruction for eligibility:"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text2(
                  text:
                      'Send your Professional qualification certificate on mealawareness@gmail.com'),
              SizedBox(height: height_ * 0.03),
              Text2(
                  text:
                      'make sure you are using the same email you used to register on the app'),
              SizedBox(height: height_ * 0.03),
              Text2(
                  text:
                      'We do not store any of your personal information, once you are verified you will be able to use the app'),
            ],
          ),
        );
      },
    );
  }
}
