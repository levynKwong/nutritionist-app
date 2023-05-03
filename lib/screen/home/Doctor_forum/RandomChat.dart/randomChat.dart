import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';

import '../../../ChatScreen/ChatScreen.dart';

class randomChat extends StatefulWidget {
  const randomChat({Key? key});

  @override
  State<randomChat> createState() => _randomChatState();
}

class _randomChatState extends State<randomChat> {
  final collectionRef = FirebaseFirestore.instance.collection('Patient');
  late QuerySnapshot usersSnapshot;
  DocumentSnapshot<Map<String, dynamic>>? randomUser;

  @override
  void initState() {
    super.initState();
    getUsersSnapshot().then((value) => getRandomUser());
  }

  Future<void> getUsersSnapshot() async {
    usersSnapshot = await collectionRef.get();
  }

  Set<String> selectedUserIds = Set<String>();

  DocumentSnapshot<Map<String, dynamic>>? previousUser;

  void getRandomUser() {
    final availableUsers = List.from(usersSnapshot.docs);
    availableUsers.removeWhere((user) =>
        user.id == FirebaseAuth.instance.currentUser!.uid ||
        user == previousUser);
    final randomIndex = Random().nextInt(availableUsers.length);
    setState(() {
      randomUser = availableUsers[randomIndex]
          as DocumentSnapshot<Map<String, dynamic>>?;
    });
    previousUser = randomUser;
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
          content(width_, height_),
          bottomContent(width_, height_)
        ],
      ),
    );
  }

  topTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.82, left: width_ * 0.05),
      child: Row(
        children: [
          Text6(text: 'Chat with friends'),
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

  Widget FindRandomUser(double width_, double height_) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              final previousUser = randomUser;
              getRandomUser();
              if (randomUser != null && randomUser != previousUser) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetail(
                      friendUid: randomUser!['uid'],
                      friendName: randomUser!['username'],
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(width_ * 0.3, 50),
              primary: const Color(0xFF575ecb), // set background color
              onPrimary: Colors.white, // set text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Find Random User'),
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
          Text5(text: 'Chat with a random person'),
        ],
      ),
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

  Widget content(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.18),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.05),
            child: Column(
              children: [
                Text(
                  'Read before pressing on the coin',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.052,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 175, 67, 67),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'With 1 Coin you are only paying half of the price, this makes sure that your appointment has been reserved'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you want to change the date of your appointment in the future, contact your nutritionist'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you want to change the date of your appointment in the future, contact your nutritionist'),
                ),
                SizedBox(height: height_ * 0.07),
                FindRandomUser(width_, height_),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center TermsofUse(double height_, double width_) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Navigate to Terms of Use page
              },
              child: Text(
                'Terms of Use',
                style: TextStyle(
                  color: Color(0xFF7B7B7B),
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' | ',
              style: TextStyle(
                color: Color(0xFF7B7B7B),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Privacy Policy page
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFF7B7B7B),
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomContent(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.77),
      child: Column(children: [
        SizedBox(height: height_ * 0.04),
        TermsofUse(height_, width_),
        SizedBox(height: height_ * 0.035),
        buttons(height_, width_)
      ]),
    );
  }
}
