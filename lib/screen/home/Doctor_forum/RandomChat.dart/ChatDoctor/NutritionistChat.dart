import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/paymentChat.dart';

class NutritionistChat extends StatefulWidget {
  const NutritionistChat({super.key});

  @override
  State<NutritionistChat> createState() => _NutritionistChatState();
}

class _NutritionistChatState extends State<NutritionistChat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<User1> _users = [];
  String _email = '';
  @override
  void initState() {
    super.initState();
    _getUsers();
    getEmail().then((email) {
      setState(() {
        _email = email;
      });
    });
  }

  Future<String> getEmail() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('email');
    } else {
      return 'email';
    }
  }

  void _getUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('Nutritionist').get();

    List<User1> users = snapshot.docs
        .map((nid) => User1.fromMap(nid.data() as Map<String, dynamic>))
        .toList();

    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarTopSearch(titleText: 'Chat with your Doctor'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height_ * 0.02),
              topSubTitle(width_, height_),
              Box(width_, height_),
              buttons(height_, width_)
            ],
          ),
        ),
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: width_ * 0.05),
          Text5(text: 'Here are our valued Nutritionist'),
        ],
      ),
    );
  }

  Box(double width_, double height_) {
    List<User1> shuffledUsers = _users.toList()..shuffle();
    shuffledUsers = shuffledUsers.toSet().toList();
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.71,
        width: MediaQuery.of(context).size.width * 1.4,
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(146, 87, 95, 203),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_users.isEmpty)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  buildUserList(shuffledUsers, width_, height_),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserList(List<User1> users, double width_, double height_) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => paymentChat(
                  nid: user.nid,
                  nutritionistName: user.username,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: height_ * 0.010,
            ),
            padding: EdgeInsets.symmetric(
              vertical: height_ * 0.014,
              horizontal: width_ * 0.07,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: width_ * 0.06,
                  backgroundImage: AssetImage('images/photoCat.png'),
                ),
                SizedBox(
                  width: width_ * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr ' + user.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width_ * 0.045,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      height: height_ * 0.01,
                    ),
                    Text(
                      user.address,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: width_ * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: height_ * 0.01,
                    ),
                    Text(
                      user.specialization,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: width_ * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: height_ * 0.01,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width_ * 0.03),
                                  ),
                                  title: Text('More info'),
                                  content: Text(
                                    'Dr. ' +
                                        user.username +
                                        ' is a ' +
                                        user.specialization +
                                        '\n\n' +
                                        'Contact no: ' +
                                        user.phoneNumber +
                                        '\n\n' +
                                        'Email: ' +
                                        user.email +
                                        '\n\n' +
                                        'Gender: ' +
                                        user.gender +
                                        user.nid,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'More info',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF575ecb),
            minimumSize: Size(width_ * 0.3, 50), // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('        Back       '),
        ),
      ],
    ));
  }
}

class User1 {
  final String username;
  final String address;
  final String email;
  final String phoneNumber;
  final String specialization;
  final String nid;
  final String gender;

  User1({
    required this.username,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.nid,
    required this.gender,
  });

  factory User1.fromMap(Map<String, dynamic> data) {
    String specialization;
    if (data['specialization'] == '1') {
      specialization = 'Sport Nutritionist';
    } else if (data['specialization'] == '2') {
      specialization = 'Pediatric Nutritionist';
    } else if (data['specialization'] == '3') {
      specialization = 'Clinical Nutritionist';
    } else if (data['specialization'] == '4') {
      specialization = 'General Nutritionist';
    } else {
      specialization = data['customSpecialization'];
    }

    String gender;
    if (data['gender'] == '10') {
      gender = 'Male';
    } else if (data['gender'] == '11') {
      gender = 'Female';
    } else {
      gender = 'Non-Binary';
    }

    return User1(
      username: data['username'],
      address: data['address'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      specialization: specialization,
      nid: data['nid'],
      gender: gender,
    );
  }
}
