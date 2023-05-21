import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/main.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/auth/login/login.dart';
import 'package:meal_aware/screen/customer_widget.dart/clientHistory.dart';
import 'package:meal_aware/screen/customer_widget.dart/clientHistoryAppointment.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileNutritionist extends StatefulWidget {
  const profileNutritionist({super.key});

  @override
  State<profileNutritionist> createState() => _profileNutritionistState();
}

class _profileNutritionistState extends State<profileNutritionist> {
  String _username = '';

  String _fullname = '';
  String? _age;
  String? _specialization = '';
  String? _address = '';
  String? _CustomSpecialization = '';
  String? _gender;
  String? _phoneNumber = '';

  @override
  void initState() {
    super.initState();

    getAge().then((age) {
      setState(() {
        _age = age;
      });
    });

    getgender().then((gender) {
      setState(() {
        _gender = gender;
      });
    });
    getPhoneNumber().then((phone) {
      setState(() {
        _phoneNumber = phone;
      });
    });

    getUserName().then((username) {
      setState(() {
        _username = username;
      });
    });
    getFullName().then((fullname) {
      setState(() {
        _fullname = fullname;
      });
    });
    getSpecialization().then((specialization) {
      setState(() {
        _specialization = specialization;
      });
    });
    getCustomSpecialization().then((customSpecialization) {
      setState(() {
        _CustomSpecialization = customSpecialization;
      });
    });
    getAddress().then((address) {
      setState(() {
        _address = address;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
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
        child: Column(
          children: [
            topRow(width_, height_),
            SizedBox(height: height_ * 0.02),
            dividingLine1(width_, height_, 0.07),
            selector(height_, width_),
          ],
        ),
      );
  Widget logout(double height_) => Container(
        child: TextButton.icon(
          onPressed: () async {
            FirebaseAuth.instance.signOut();

            // Remove saved login credentials from shared preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear(); // This will remove all shared preferences

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
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
        margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
        child: Column(
          children: [
            //
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => clientHistory(),
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
                    'images/to-do-list.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Text(
                    'Client History Chat',
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => clientHistoryAppointment(),
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
                    'images/to-do-list.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Text(
                    'Client History Appointment',
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
            Text(
                'If you want to change your information or obtain any information, please contact us:'),
            Text('mealawareness@gmail.com'),
            SizedBox(height: height_ * 0.02),
            listFullname(height_, width_),
            SizedBox(height: height_ * 0.01),
            listAge(height_, width_),
            SizedBox(height: height_ * 0.01),
            listGender(height_, width_),
            SizedBox(height: height_ * 0.01),
            listSpecialization(height_, width_),
            SizedBox(height: height_ * 0.01),
            listAddress(height_, width_),
            SizedBox(height: height_ * 0.01),
            listPhoneNumber(height_, width_),

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
          backgroundImage: AssetImage('images/OIB.png'),
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
                    Text4(text: 'Nutritionist'),
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

  Widget dividingLine1(double width_, double height_, double height) =>
      Container(
        margin: EdgeInsets.only(
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

    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(uid)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('username');
    } else {
      return 'Username';
    }
  }

  Future<String> getFullName() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('fullname');
    } else {
      return 'Username';
    }
  }

  Future<String?> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('age');
    } else {
      return null;
    }
  }

  Future<String?> getgender() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('gender');
    } else {
      return null;
    }
  }

  Future<String?> getSpecialization() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('specialization');
    } else {
      return null;
    }
  }

  Future<String?> getCustomSpecialization() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('customSpecialization');
    } else {
      return null;
    }
  }

  Future<String?> getAddress() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('address');
    } else {
      return null;
    }
  }

  Future<String?> getPhoneNumber() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('phoneNumber');
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
            child: Text(
              (() {
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
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listFullname(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'FullName',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$_fullname',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
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
            child: Text(
              (() {
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
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listSpecialization(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Specialization',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (() {
                switch (_specialization) {
                  case '1':
                    return 'Sport Nutritionist';
                  case '2':
                    return 'Pediatric Nutritionist';
                  case '3':
                    return 'Clinical Nutritionist';
                  case '4':
                    return 'General Nutritionist';

                  default:
                    return '$_CustomSpecialization';
                }
              }()),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listAddress(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ('$_address'),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listPhoneNumber(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ('$_phoneNumber'),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
