import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/login/login.dart';

import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/divider.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/BuyCoin.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int _coin = 0;
  String _username = '';
  String? _age;

  String? _country;

  String? _gender;
  // late String gender;
  // late String country;

  String? _activityLevel;
  String? _bodyGoal;
  String? _dietType;

  List<int> cmHeights = List.generate(
      200,
      (index) =>
          index +
          60); // Create a list of integers representing the available height options in centimeters

  int? selectedCmHeight;
  List<int> Weight = List.generate(
      150,
      (index) =>
          index +
          20); // Create a list of integers representing the available height options in centimeters

  int? selectedWeight;
  int? IdealselectedWeight;
  List<int> IdealWeight = List.generate(150, (index) => index + 20);
  int? MealPerDay;
  List<int> meal = List.generate(10, (index) => index + 0);
  @override
  void initState() {
    super.initState();

    getAge().then((value) {
      setState(() {
        _age = value;
      });
    });
    getCountry().then((value) {
      setState(() {
        _country = value;
      });
    });
    getgender().then((value) {
      setState(() {
        _gender = value;
      });
    });
    getActivityLevel().then((value) {
      setState(() {
        _activityLevel = value;
      });
    });
    getBodyGoal().then((value) {
      setState(() {
        _bodyGoal = value;
      });
    });
    getDietaryPreferenceList().then((value) {
      setState(() {
        _dietType = value;
      });
    });
    getCoin().then((coin) {
      setState(() {
        _coin = coin;
      });
    });
    getUserName().then((username) {
      setState(() {
        _username = username;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: appBarTop(
          titleText: 'Profile',
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/pattern_food.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              width: width_,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height_ * 0.01),
                  topContent(height_, width_),
                  SizedBox(height: height_ * 0.01),
                  buildProfileHeader(width_, height_),
                  SizedBox(height: height_ * 0.02),
                  Content(width_, height_)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topContent(double height_, double width_) => Container(
        width: double.infinity,
        child: Stack(
          children: [
            topTitle(height_, width_),
          ],
        ),
      );
  Widget topTitle(double height_, double width_) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height_ * 0.01),
            Text(
              '$_username',
              style: TextStyle(
                  fontSize: width_ * 0.1,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: height_ * 0.01),
            Text(
              'Username',
              style: TextStyle(
                  fontSize: width_ * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 132, 132, 132)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader(double width_, double height_) => Center(
        child: Column(
          children: [
            Stack(
              children: [
                buildProfileImage(width_, height_),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget Content(double width_, double height_) => Container(
        child: Stack(
          children: [
            topRow(width_, height_),
            dividingLine1(width_, height_, 0.07),
            bottomRow(width_, height_),
            dividingLine1(width_, height_, 0.20),
            selector(height_, width_),
          ],
        ),
      );
  Widget logout(double height_) => Container(
        child: TextButton.icon(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          icon: Icon(Icons.power_settings_new,
              color: Colors.red), // Add your icon here
          label: Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 233, 58, 58),
            ),
          ),
        ),
      );

  Widget selector(double height_, double width_) => Container(
        margin: EdgeInsets.only(
            top: height_ * 0.22, left: width_ * 0.1, right: width_ * 0.1),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyCoin(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/tokenIcon.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Text(
                    'Buy Coin',
                    style: TextStyle(
                      fontSize: width_ * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: width_ * 0.06),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/to-do-list.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Text(
                    'Purchase History',
                    style: TextStyle(
                      fontSize: width_ * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            dividingLine2(width_, height_, 0),
            listAge(height_, width_),
            listCountry(height_, width_),
            listGender(height_, width_),
            listHeight(height_, width_),
            listweight(height_, width_),
            listIdealweight(height_, width_),
            listMealPerDay(height_, width_),
            listActivityLevel(height_, width_),
            listBodyGoal(height_, width_),
            listDietaryPreference(height_, width_),
            SizedBox(height: height_ * 0.02),
            dividingLine2(width_, height_, 0),
            logout(height_),
          ],
        ),
      );

  Widget buildProfileImage(double width_, double height_) => CircleAvatar(
        radius: width_ * 0.18,
        backgroundColor: Color.fromARGB(255, 130, 130, 130),
        child: CircleAvatar(
          radius: width_ * 0.16,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('images/photoCat.png'),
        ),
      );

  Widget topRow(double width_, double height_) => Container(
        // margin: EdgeInsets.only(
        //     bottom: height_ * 0.55, left: width_ * 0.1, right: width_ * 0.1),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Age'),
                    SizedBox(height: height_ * 0.01),
                    Text4(
                      text: (() {
                        switch (_age) {
                          case '1':
                            return '1-5';
                          case '2':
                            return '6-10';
                          case '3':
                            return '11-15';
                          case '4':
                            return '16-18';
                          case '5':
                            return '6-18';
                          case '6':
                            return '19-24';
                          case '7':
                            return '25-34';
                          case '8':
                            return '35-44';
                          case '9':
                            return '45-54';
                          case '10':
                            return '55-64';
                          case '11':
                            return '65+';
                          default:
                            return '';
                        }
                      }()),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color.fromARGB(255, 86, 86, 86),
                thickness: 1,
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Status'),
                    SizedBox(height: height_ * 0.01),
                    Text4(text: 'Patient'),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color.fromARGB(255, 86, 86, 86),
                thickness: 1,
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Gender'),
                    SizedBox(height: height_ * 0.01),
                    Text4(
                      text: (() {
                        switch (_gender) {
                          case '1':
                            return 'Male';
                          case '2':
                            return 'Female';
                          case '3':
                            return 'Non-binary';

                          default:
                            return '';
                        }
                      }()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bottomRow(double width_, double height_) => Container(
        margin: EdgeInsets.only(
          top: height_ * 0.09,
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          SizedBox(width: width_ * 0.04),
                          Image.asset(
                            'images/token_.png',
                            width: width_ * 0.08,
                            height: height_ * 0.08,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: width_ * 0.04),
                          Text3(text: 'Coin'),
                        ],
                      ),
                    ),
                    SizedBox(height: height_ * 0.0001),
                    Center(
                      child: Text4(text: '$_coin'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: width_ * 0.04),
              VerticalDivider(
                color: Color.fromARGB(255, 86, 86, 86),
                thickness: 1,
                width: 8,
              ),
              SizedBox(width: width_ * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          SizedBox(width: width_ * 0.04),
                          Image.asset(
                            'images/order.png',
                            width: width_ * 0.08,
                            height: height_ * 0.08,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: width_ * 0.04),
                          Text3(text: 'Orders'),
                        ],
                      ),
                    ),
                    SizedBox(height: height_ * 0.0001),
                    Center(
                      child: Text4(text: '1'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget dividingLine1(double width_, double height_, double height) =>
      Container(
        margin: EdgeInsets.only(
          top: height_ * height,
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );
  Widget dividingLine2(double width_, double height_, double height) =>
      Container(
        margin: EdgeInsets.only(
          bottom: height_ * height,
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );

  Future<int> getCoin() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final docSnapshot =
        await FirebaseFirestore.instance.collection('Patient').doc(uid).get();

    if (docSnapshot.exists) {
      return docSnapshot.get('coin');
    } else {
      return 0;
    }
  }

  Future<String> getUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final docSnapshot =
        await FirebaseFirestore.instance.collection('Patient').doc(uid).get();

    if (docSnapshot.exists) {
      return docSnapshot.get('username');
    } else {
      return 'Username';
    }
  }

  final List<DropdownMenuItem<String>> ageList = [
    DropdownMenuItem(
      value: '1',
      child: Text('1-5'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('6-10'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('11-15'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('16-18'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('6-18'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('19-24'),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('25-34'),
    ),
    DropdownMenuItem(
      value: '8',
      child: Text('35-44'),
    ),
    DropdownMenuItem(
      value: '9',
      child: Text('45-54'),
    ),
    DropdownMenuItem(
      value: '10',
      child: Text('55-64'),
    ),
    DropdownMenuItem(
      value: '11',
      child: Text('65+'),
    ),
  ];
  final List<DropdownMenuItem<String>> countryList = [
    DropdownMenuItem(
      value: '1',
      child: Text('Mauritius'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Abroad'),
    ),
  ];
  final List<DropdownMenuItem<String>> genderList = [
    DropdownMenuItem(
      value: '1',
      child: Text('        Male'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('       Female'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('   Non-Binary'),
    ),
  ];

  final List<DropdownMenuItem<String>> activityLevelList = [
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
  ];

  final List<DropdownMenuItem<String>> BodyGoalList = [
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
  ];

  final List<DropdownMenuItem<String>> DietaryPreferenceList = [
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
  ];

  Future<String?> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('age');
    } else {
      return null;
    }
  }

  Future<String?> getCountry() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('Country');
    } else {
      return null;
    }
  }

  Future<String?> getgender() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('gender');
    } else {
      return null;
    }
  }

  Future<int?> getheight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('Height');
    } else {
      return null;
    }
  }

  Future<int?> getWeight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('Weight');
    } else {
      return null;
    }
  }

  Future<int?> getIdealWeight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('IdealWeight');
    } else {
      return null;
    }
  }

  Future<int?> getMealPerDay() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('MealPerDay');
    } else {
      return null;
    }
  }

  Future<String?> getActivityLevel() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('selectedActivityLevel');
    } else {
      return null;
    }
  }

  Future<String?> getBodyGoal() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('selectedBodyGoal');
    } else {
      return null;
    }
  }

  Future<String?> getDietaryPreferenceList() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('dietaryPreference');
    } else {
      return null;
    }
  }

  Widget listAge(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Age',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _age,
                  items: ageList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _age = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'age': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listCountry(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Country',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _country,
                  items: countryList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _country = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'Country': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listGender(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Gender',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _gender,
                  items: genderList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _gender = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'gender': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listHeight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getheight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          selectedCmHeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Height',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: selectedCmHeight,
                      items: cmHeights.map((int height) {
                        return DropdownMenuItem<int>(
                          value: height,
                          child: Text("$height cm"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          selectedCmHeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(userId)
                            .update({'Height': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listweight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getWeight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          selectedWeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: selectedWeight,
                      items: Weight.map((int weight) {
                        return DropdownMenuItem<int>(
                          value: weight,
                          child: Text("$weight kg"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          selectedWeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(userId)
                            .update({'Weight': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listIdealweight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getIdealWeight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          IdealselectedWeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Ideal Weight',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: IdealselectedWeight,
                      items: IdealWeight.map((int IdealWeight) {
                        return DropdownMenuItem<int>(
                          value: IdealWeight,
                          child: Text("$IdealWeight kg"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          IdealselectedWeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(userId)
                            .update({'IdealWeight': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listMealPerDay(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getMealPerDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          MealPerDay =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Meal per day',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: MealPerDay,
                      items: meal.map((int meal) {
                        return DropdownMenuItem<int>(
                          value: meal,
                          child: Text("$meal"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          MealPerDay = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(userId)
                            .update({'MealPerDay': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listActivityLevel(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Activity Level',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _activityLevel,
                  items: activityLevelList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _activityLevel = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'selectedActivityLevel': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listBodyGoal(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Body Goal',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _bodyGoal,
                  items: BodyGoalList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _bodyGoal = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'selectedBodyGoal': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listDietaryPreference(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Dietary preference or restriction',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _dietType,
                  items: DietaryPreferenceList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _dietType = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            userId) // Replace "patientId" with the ID of the current patient
                        .update({'selectedBodyGoal': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
