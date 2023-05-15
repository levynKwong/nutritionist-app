import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class PatientAdditionalDetail extends StatefulWidget {
  const PatientAdditionalDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientAdditionalDetail> createState() =>
      _PatientAdditionalDetailState();
}

class _PatientAdditionalDetailState extends State<PatientAdditionalDetail> {
  final _formKey = GlobalKey<FormState>();

  _PatientAdditionalDetailState();
  String? country;
  String? _selectedBodyGoal;
  int num = 1;
  String? gender;
  String? _selectedActivityLevel;
  String? _DietaryPreference;
  List<int> cmHeights = List.generate(
      200,
      (index) =>
          index +
          0); // Create a list of integers representing the available height options in centimeters

  int? selectedCmHeight;
  List<int> Weight = List.generate(
      150,
      (index) =>
          index +
          0); // Create a list of integers representing the available height options in centimeters

  int? selectedWeight;
  int? IdealselectedWeight;
  List<int> IdealWeight = List.generate(150, (index) => index + 0);

  int? MealPerDay;
  List<int> meal = List.generate(10, (index) => index + 0);

  Future<void> updatePatientDataToFirestore(
    String? country,
    int? selectedCmHeight,
    int? selectedWeight,
    int? IdealselectedWeight,
    String? selectedBodyGoal,
    int? MealPerDay,
    String? selectedActivityLevel,
    String? dietaryPreference,
    String? gender,
    int num,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('Patient')
          .doc(userId)
          .update({
        'Country': country,
        'Height': selectedWeight?.toInt(),
        'Weight': selectedWeight?.toInt(),
        'IdealWeight': IdealselectedWeight?.toInt(),
        'selectedBodyGoal': selectedBodyGoal,
        'MealPerDay': MealPerDay?.toInt(),
        'selectedActivityLevel': selectedActivityLevel,
        'dietaryPreference': dietaryPreference,
        'gender': gender,
        'registrationProgress': num,
      });

      print("Data updated in Firestore");
    } catch (error) {
      print("Failed to update data: $error");
    }
  }

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
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Country',
                                        prefixIcon: Icon(Icons.map),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: country,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Mauritius'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Abroad'),
                                        ),
                                      ],
                                      onChanged: (String? Value) {
                                        setState(() {
                                          country = Value;
                                        });
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.025),
                                    // Declare a variable to hold the selected height value

                                    // Note the nullable type declaration

                                    DropdownButtonFormField<int>(
                                      value: selectedCmHeight,
                                      decoration: InputDecoration(
                                        labelText: 'Select height in cm',
                                        prefixIcon: Icon(Icons.height),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (int? value) {
                                        // Note the nullable parameter type
                                        if (value != null) {
                                          // Null check added
                                          setState(() {
                                            selectedCmHeight = value;
                                          });
                                        }
                                      },
                                      items: cmHeights.map((int height) {
                                        return DropdownMenuItem<int>(
                                          value: height,
                                          child: Text("$height cm"),
                                        );
                                      }).toList(),
                                    ),

                                    SizedBox(height: height_ * 0.025),
                                    DropdownButtonFormField<int>(
                                      value: selectedWeight,
                                      decoration: InputDecoration(
                                        labelText: 'Select Weight in Kg',
                                        prefixIcon: Icon(Icons.monitor_weight),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (int? value) {
                                        // Note the nullable parameter type
                                        if (value != null) {
                                          // Null check added
                                          setState(() {
                                            selectedWeight = value;
                                          });
                                        }
                                      },
                                      items: Weight.map((int weight) {
                                        return DropdownMenuItem<int>(
                                          value: weight,
                                          child: Text("$weight Kg"),
                                        );
                                      }).toList(),
                                    ),

                                    SizedBox(height: height_ * 0.025),

                                    DropdownButtonFormField<int>(
                                      value: IdealselectedWeight,
                                      decoration: InputDecoration(
                                        labelText: 'Ideal Body Weight in Kg',
                                        prefixIcon: Icon(Icons.monitor_weight),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (int? value) {
                                        // Note the nullable parameter type
                                        if (value != null) {
                                          // Null check added
                                          setState(() {
                                            IdealselectedWeight = value;
                                          });
                                        }
                                      },
                                      items: IdealWeight.map((int Idealweight) {
                                        return DropdownMenuItem<int>(
                                          value: Idealweight,
                                          child: Text("$Idealweight Kg"),
                                        );
                                      }).toList(),
                                    ),

                                    SizedBox(height: height_ * 0.025),
                                    DropdownButtonFormField<int>(
                                      value: MealPerDay,
                                      decoration: InputDecoration(
                                        labelText: 'Number of meals per day',
                                        prefixIcon: Icon(Icons.set_meal),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (int? value) {
                                        // Note the nullable parameter type
                                        if (value != null) {
                                          // Null check added
                                          setState(() {
                                            MealPerDay = value;
                                          });
                                        }
                                      },
                                      items: meal.map((int meal) {
                                        return DropdownMenuItem<int>(
                                          value: meal,
                                          child: Text("$meal"),
                                        );
                                      }).toList(),
                                    ),

                                    SizedBox(height: height_ * 0.025),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Body Goal',
                                        prefixIcon: Icon(Icons.done),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedBodyGoal,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Muscle Gain'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Fat Loss'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Maintenance'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('Rapid Weight Loss'),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedBodyGoal = value;
                                        });
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Activity Level',
                                        prefixIcon: Icon(Icons.sports_handball),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedActivityLevel,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Sedentary'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Light Active'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Moderately Active'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('Very Active'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('Extremely Active'),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedActivityLevel = value;
                                        });
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),

                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Dietary Preference',
                                        prefixIcon: Icon(Icons.food_bank),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _DietaryPreference,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Vegetarian'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Vegan'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Normal'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('Gluten-free'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('Paleo'),
                                        ),
                                        DropdownMenuItem(
                                          value: '6',
                                          child: Text('Keto'),
                                        ),
                                        DropdownMenuItem(
                                          value: '7',
                                          child: Text('Mediterranean'),
                                        ),
                                        DropdownMenuItem(
                                          value: '8',
                                          child: Text('Pescetarian'),
                                        ),
                                      ],
                                      onChanged: (String? Value) {
                                        setState(() {});
                                        _DietaryPreference = Value;
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
                                      onChanged: (String? Value) {
                                        setState(() {});
                                        gender = Value;
                                      },
                                    ),
                                    SizedBox(height: height_ * 0.02),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                                updatePatientDataToFirestore(
                                    country,
                                    selectedCmHeight,
                                    selectedWeight,
                                    IdealselectedWeight,
                                    _selectedBodyGoal,
                                    MealPerDay,
                                    _selectedActivityLevel,
                                    _DietaryPreference,
                                    gender,
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
                          SizedBox(height: height_ * 0.05),
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
}
