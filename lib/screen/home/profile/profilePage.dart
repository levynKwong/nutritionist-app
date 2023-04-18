import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/divider.dart';
import 'package:meal_aware/screen/auth/auth_screen.dart';
import 'package:meal_aware/screen/customer_widget.dart/text1.dart';
import 'package:meal_aware/screen/customer_widget.dart/text2.dart';

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
          height: height_ * 2,
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
        margin: EdgeInsets.only(bottom: height_ * 1.75),
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
        margin: EdgeInsets.only(top: height_ * 0.4),
        width: double.infinity,
        child: Stack(
          children: [
            topRow(width_, height_),
            dividingLine1(width_, height_, 0.055),
            bottomRow(width_, height_),
            dividingLine1(width_, height_, 0.17),
            selector(height_, width_),
            dividingLine2(width_, height_, 1.22),
          ],
        ),
      );
  Widget logout(double height_) => Container(
        margin: EdgeInsets.only(top: height_ * 0.014),
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
            top: height_ * 0.18, left: width_ * 0.1, right: width_ * 0.1),
        child: Column(
          children: [
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
                    'Buy Token',
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
            list(height_, width_, 'Age', '18-50', 0.37, 0.11),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Gender', 'Female', 0.28, 0.11),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Country', 'Moderately Active', 0.08, 0.11),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Height', '1m 70cm', 0.26, 0.11),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Current Body Weight', '60kg', 0.02, 0.114),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Target Body Weight', '55kg', 0.04, 0.114),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'No of Meal per day', '3', 0.12, 0.114),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Body Goal', 'Muscle Gain', 0.12, 0.114),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Activity Level', 'Moderately Active', 0.001,
                0.05),
            SizedBox(height: height_ * 0.02),
            list(height_, width_, 'Dietary Preference\n\or restrictions ',
                'Vegetarian', 0.02, 0.05),
            SizedBox(height: height_ * 0.02),
            logout(height_),
          ],
        ),
      );
  Widget list(double height_, double width_, String text1, String text2,
      double space1, double space2) {
    return SingleChildScrollView(
      child: Row(
        children: [
          // SizedBox(width: height_ * 0.1),
          Text(
            text1,
            style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(width: width_ * space1),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  text2,
                  style: TextStyle(
                      fontSize: width_ * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 86, 86, 86)),
                ),
                SizedBox(width: width_ * space2),
                Icon(Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 86, 86, 86),
                    size: width_ * 0.04),
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
          backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
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
                    Text(
                      'Age',
                      style: title,
                    ),
                    SizedBox(height: height_ * 0.01),
                    Text(
                      '20',
                      style: subtitle,
                    )
                  ],
                ),
              ),
              SizedBox(height: height_ * 0.01),
              VerticalDivider(
                color: Color(0xFFd9f2ff),
                thickness: 1,
                width: 8,
              ),
              SizedBox(height: height_ * 0.01),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Status',
                      style: title,
                    ),
                    SizedBox(height: height_ * 0.01),
                    Text(
                      'Patient',
                      style: subtitle,
                    )
                  ],
                ),
              ),
              SizedBox(height: height_ * 0.01),
              VerticalDivider(
                color: Color(0xFFd9f2ff),
                thickness: 1,
                width: 8,
              ),
              SizedBox(height: height_ * 0.01),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Gender',
                      style: title,
                    ),
                    SizedBox(height: height_ * 0.01),
                    Text(
                      'Female',
                      style: subtitle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bottomRow(double width_, double height_) => Container(
        margin: EdgeInsets.only(
          top: height_ * 0.07,
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
                          Text(
                            'Token',
                            style: title,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height_ * 0.0001),
                    Center(
                      child: Text(
                        '1',
                        style: subtitle,
                      ),
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
                          Text(
                            'Orders',
                            style: title,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height_ * 0.0001),
                    Center(
                      child: Text(
                        '1',
                        style: subtitle,
                      ),
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
          top: height_ * height,
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 112, 112, 112),
          thickness: 1,
        ),
      );
  TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    decoration: TextDecoration.none,
  );

  TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 0, 0, 0),
    decoration: TextDecoration.none,
  );
}
