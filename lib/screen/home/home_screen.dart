import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/home/profile/profilePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final screens = [
    Center(child: Text('Journal')),
    Center(child: Text('Message')),
    DoctorForum(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          background(),
          screens[_currentIndex],
          Positioned(
            top: height_ * 0.08,
            right: width_ * 0.01,
            child: Material(
              elevation:
                  0, // add elevation to bring the widget to the foreground
              color: Colors.transparent, // set background color to transparent
              child: InkWell(
                onTap: () {
                  // Handle the onTap event here
                  // For example, navigate to a notification screen
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF989efd), // Set background color here
            icon: Icon(
              Icons.book,
              color: Colors.black,
            ),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF989efd),
            icon: Icon(
              Icons.message,
              color: Colors.black,
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF989efd),
            icon: Icon(
              Icons.face,
              color: Colors.black,
            ),
            label: 'Doctor Forum',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF989efd),
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
