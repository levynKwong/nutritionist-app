import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/divider.dart';

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
    final double profileHeight = height_ * 0.3;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          background(),
          cover(width_, height_),
          Column(
            children: [
              Positioned(
                top: height_ * 0.06,
                child: Column(
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
            ],
          ),
          buildProfileHeader(width_, height_),
          topRow(width_, height_),
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

  Widget buildProfileHeader(double width_, double height_) => Column(
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

  Widget topRow(double width_, double height_) => IntrinsicHeight(
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
