import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/terms_of_use_and_services.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

class randomChat extends StatefulWidget {
  const randomChat({Key? key});

  @override
  State<randomChat> createState() => _randomChatState();
}

class _randomChatState extends State<randomChat> {
  bool _currentAge = false;
  bool _userAvailable = false;
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

  Future<void> getRandomUser() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();
    final currentAge = userDoc.data()?['age'];

    if (currentAge == null) {
      print('Current age not found.');
      return;
    }

    await getUsersSnapshot(); // wait for getUsersSnapshot to complete

    final availableUsers = usersSnapshot.docs;

    if (availableUsers.isEmpty) {
      _userAvailable = true;
      print('No available users.');
      return;
    } else {
      _userAvailable = false;
    }

    final sameAgeUsers = availableUsers
        .where((user) => user.get('age') == currentAge && user.id != currentId)
        .toList();

    if (sameAgeUsers.isEmpty) {
      _currentAge = true;
      print('No available users of same age.');
      return;
    } else {
      _currentAge = false;
    }

    final randomIndex = Random().nextInt(sameAgeUsers.length);
    if (mounted) {
      setState(() {
        randomUser = sameAgeUsers[randomIndex]
            as DocumentSnapshot<Map<String, dynamic>>?;
      });
    }
  }

  Widget noAvailableUsers(
      {required String message, required VoidCallback onOKPressed}) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height_ * 0.05),
            ElevatedButton(
              onPressed: onOKPressed,
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: getColor(context), // Set the background color to blue
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentAgeNotFound(
      {required String message, required VoidCallback onOKPressed}) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height_ * 0.05),
            ElevatedButton(
              onPressed: onOKPressed,
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: getColor(context), // Set the background color to blue
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarTop(titleText: 'Chat with friends'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height_ * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: width_ * 0.05),
                  Text5(text: 'Chat with a random person'),
                ],
              ),
              SizedBox(height: height_ * 0.05),
              content(width_, height_),
              bottomContent(width_, height_),
              SizedBox(height: height_ * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget FindRandomUser(double width_, double height_) {
    DocumentSnapshot<Map<String, dynamic>>? previousUser;

    Future<void> handleButtonPress() async {
      if (_currentAge) {
        showDialog(
          context: context,
          builder: (context) => currentAgeNotFound(
            message: 'Current age not found.',
            onOKPressed: () => Navigator.of(context).pop(),
          ),
        );
      } else if (_userAvailable) {
        showDialog(
          context: context,
          builder: (context) => noAvailableUsers(
            message: 'No available users.',
            onOKPressed: () => Navigator.of(context).pop(),
          ),
        );
      } else {
        await getRandomUser();
        if (randomUser != null && randomUser != previousUser) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetail(
                friendUid: randomUser!['pid'],
                friendName: randomUser!['username'],
              ),
            ),
          );
          previousUser = randomUser;
        }
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: handleButtonPress,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF575ecb),
              minimumSize: Size(width_ * 0.3, 50),
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

  Widget content(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.05),
            child: Column(
              children: [
                Text(
                  'Read before pressing on Button',
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
                          'Before you start chatting, please keep in mind that this is a public platform and that you should always be respectful and kind to others.'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'Be mindful of your words and actions when chatting with others. Remember, we are all here to help and connect with one another as we may share similar issues.'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you are being harassed or bullied, please report the user immediately.'),
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

  Widget bottomContent(double width_, double height_) {
    return Container(
      child: Column(children: [
        SizedBox(height: height_ * 0.04),
        termNcondition(),
        SizedBox(height: height_ * 0.035),
        buttons(height_, width_)
      ]),
    );
  }
}
