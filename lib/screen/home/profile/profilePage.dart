import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/divider.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/BuyCoin.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: height_ * 1.8,
          child: Stack(
            children: [
              background(),
              topContent(height_, width_),
              Content(width_, height_)
            ],
          ),
        ),
      ),
    );
  }

  Widget topContent(double height_, double width_) => Container(
        width: double.infinity,
        child: Stack(
          children: [
            cover(width_, height_),
            topTitle(height_, width_),
            buildProfileHeader(width_, height_),
          ],
        ),
      );
  Widget topTitle(double height_, double width_) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: height_ * 1.55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                  fontSize: width_ * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: height_ * 0.01),
            Text(
              'Your Name',
              style: TextStyle(
                  fontSize: width_ * 0.1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
            SizedBox(height: width_ * 0.44),
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
        margin: EdgeInsets.only(top: height_ * 0.43),
        width: double.infinity,
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
                builder: (context) => AuthScreen(),
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
                      fontSize: width_ * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                    'images/tokenIcon.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Text(
                    'Purchase History',
                    style: TextStyle(
                      fontSize: width_ * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            divider(),
            list(height_, width_, 'Age', '18-50'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Gender', 'Female'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Country', 'Mauritius'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Height', '1m 70cm'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Current Body Weight', '60kg'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Target Body Weight', '55kg'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'No of Meal per day', '3'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Body Goal', 'Muscle Gain'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Activity Level', 'Moderately \n\ Active'),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Dietary Preference\n\or restrictions ',
                'Vegetarian'),
            SizedBox(height: height_ * 0.02),
            dividingLine2(width_, height_, 0),
            logout(height_),
          ],
        ),
      );

  Widget list(
    double height_,
    double width_,
    String text1,
    String text2,
  ) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Text(
              text1,
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
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        text2,
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 86, 86, 86),
                        ),
                      ),
                      SizedBox(width: width_ * 0.01),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cover(double width_, double height_) => Positioned(
        top: height_ * -0.50,
        right: width_ * -0.06,
        child: Container(
          width: width_ * 1.1,
          height: height_ * 1.1,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF9584ff),
                Color(0xFF8ce4ff),
              ],
              radius: 1,
              center: Alignment(0, 1),
            ),
            shape: BoxShape.circle,
          ),
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
                color: Color(0xFFd9f2ff),
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
                color: Color(0xFFd9f2ff),
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
                      child: Text4(text: '1'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: width_ * 0.04),
              VerticalDivider(
                color: Color(0xFFd9f2ff),
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
                            'images/token_.png',
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
          color: Color(0xFFd9f2ff),
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
          color: Color.fromARGB(255, 112, 112, 112),
          thickness: 1,
        ),
      );
}
