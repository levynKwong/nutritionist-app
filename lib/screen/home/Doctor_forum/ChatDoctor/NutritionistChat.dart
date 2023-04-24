import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';

class NutritionistChat extends StatefulWidget {
  const NutritionistChat({super.key});

  @override
  State<NutritionistChat> createState() => _NutritionistChatState();
}

class _NutritionistChatState extends State<NutritionistChat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('Nutritionist').get();

    List<User> users = snapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
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
      body: Stack(
        children: [
          background(),
          topTitle(width_, height_),
          topSubTitle(width_, height_),
          searchBar(width_, height_),
          Box(width_, height_),
          buttons(height_, width_)
        ],
      ),
    );
  }

  topTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.82, left: width_ * 0.05),
      child: Row(
        children: [
          Text6(text: 'Nutritionist'),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: NotificationWidget(),
            ),
          ),
        ],
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.74, left: width_ * 0.05),
      child: Row(
        children: [
          Text5(text: 'Here are our valued Nutritionist'),
        ],
      ),
    );
  }

  searchBar(width_, height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.16, left: width_ * 0.05, right: width_ * 0.05),
      height: height_ * 0.042,
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 1, 1, 1)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          hintText: 'Search here for category',
          prefixIcon: Icon(Icons.search, size: 30, color: Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: height_ * 0.01),
        ),
      ),
    );
  }

  Box(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
        top: height_ * 0.21,
        left: width_ * 0.001,
        right: width_ * 0.001,
      ),
      child: Form(
        // key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          width: MediaQuery.of(context).size.width * 1.4,
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(104, 214, 228, 239),
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
                  _users.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                print('pressed');
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
                                      backgroundImage: NetworkImage(
                                        //  _users[index].photoUrl,
                                        'https://th.bing.com/th/id/R.62325205054ee42cbd441c7036a7e3ec?rik=RHdJrVUP%2b%2b8klA&pid=ImgRaw&r=0',
                                      ),
                                    ),
                                    SizedBox(
                                      width: width_ * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr ' + _users[index].username,
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
                                          _users[index].address,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: width_ * 0.04,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height_ * 0.01,
                                        ),
                                        Text(
                                          _users[index].specialization,
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      width_ *
                                                                          0.03),
                                                        ),
                                                        title: Text('Review'),
                                                        content: Text('Dr. ' +
                                                            _users[index]
                                                                .username +
                                                            ' is a ' +
                                                            _users[index]
                                                                .specialization +
                                                            '\n\n' +
                                                            'Contact no: ' +
                                                            _users[index]
                                                                .phoneNumber +
                                                            '\n\n' +
                                                            'Email: ' +
                                                            _users[index]
                                                                .email),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Close'))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                'review',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width_ * 0.15,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      width_ *
                                                                          0.03),
                                                        ),
                                                        title:
                                                            Text('More info'),
                                                        content: Text('Dr. ' +
                                                            _users[index]
                                                                .username +
                                                            ' is a ' +
                                                            _users[index]
                                                                .specialization +
                                                            '\n\n' +
                                                            'Contact no: ' +
                                                            _users[index]
                                                                .phoneNumber +
                                                            '\n\n' +
                                                            'Email: ' +
                                                            _users[index]
                                                                .email),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Close'))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                'More info',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        margin: EdgeInsets.only(top: height_ * 0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width_ * 0.3, 50),
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
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

class User {
  final String username;
  final String address;
  final String email;
  final String phoneNumber;
  final String specialization;

  User({
    required this.username,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    String Specialization;
    if (data['specialization'] == '1') {
      Specialization = 'Sport Nutritionist';
    } else if (data['specialization'] == '2') {
      Specialization = 'Pediatric Nutritionist';
    } else if (data['specialization'] == '3') {
      Specialization = 'Clinical Nutritionist';
    } else if (data['specialization'] == '4') {
      Specialization = 'General Nutritionist';
    } else {
      Specialization = data['customSpecialization'];
    }
    return User(
      username: data['username'],
      address: data['address'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      specialization: Specialization,
    );
  }
}
