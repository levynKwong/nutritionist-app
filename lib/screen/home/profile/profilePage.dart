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
  String _age = '';
  late String age = '';

  String _gender = '';
  late String gender;
  String _country = '';
  late String country;
  int _height = 0;
  late String height;
  int _currentBodyWeight = 0;
  late String currentBodyWeight;
  int _targetBodyWeight = 0;
  late String targetBodyWeight;
  int _noOfMeal = 0;
  late String noOfMeal;
  String _bodyGoal = '';
  late String bodyGoal;
  String _activityLevel = '';
  late String activityLevel;
  String _dietType = '';
  late String dietType;

  void change() {
    if (_age == '1') {
      setState(() {
        age = '1-18';
      });
    } else if (_age == '2') {
      setState(() {
        age = '19-24';
      });
    } else if (_age == '3') {
      setState(() {
        age = '25-34';
      });
    } else if (_age == '4') {
      setState(() {
        age = '35-44';
      });
    } else if (_age == '5') {
      setState(() {
        age = '45-54';
      });
    } else if (_age == '6') {
      setState(() {
        age = '55-64';
      });
    } else if (_age == '7') {
      setState(() {
        age = '65+';
      });
    } else if (_age == '8') {
      setState(() {
        age = '1-5';
      });
    } else if (_age == '9') {
      setState(() {
        age = '6-10';
      });
    } else if (_age == '10') {
      setState(() {
        age = '11-15';
      });
    } else if (_age == '11') {
      setState(() {
        age = '16-18';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getAge().then((age) {
      setState(() {
        _age = age;
        change();
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
          child: SizedBox(
            child: Column(
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
        margin: EdgeInsets.only(top: height_ * 0.03),
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
                    Text4(text: '20'),
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
                    Text4(text: 'Female'),
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
      child: Text('1-18'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('19-24'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('25-34'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('35-44'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('45-54'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('55-64'),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('65+'),
    ),
  ];

  Future<String> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('age');
    } else {
      return 'age';
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
                  onChanged: (String? value) {
                    setState(() {
                      _age = value!;
                      change(); // Call the change function to update the age value

                      // Update the "age" field in the "Patient" document in Firestore
                      FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(
                              userId) // Replace "patientId" with the ID of the current patient
                          .update({'age': value})
                          .then((value) => print('Age updated'))
                          .catchError(
                              (error) => print('Failed to update age: $error'));
                    });
                  },
                  items: ageList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
