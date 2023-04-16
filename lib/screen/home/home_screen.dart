import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final screens = [
    Center(child: Text('Journal')),
    Center(child: Text('Message')),
    DoctorForum(),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          screens[_currentIndex],
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
