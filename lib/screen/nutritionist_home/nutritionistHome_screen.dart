import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/home/Message/message.dart';
import 'package:meal_aware/screen/home/profile/profilePage.dart';
import 'package:meal_aware/screen/customer_widget.dart/topRightCoinCounter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_aware/screen/nutritionist_home/dashboard/dashboard.dart';
import 'package:meal_aware/screen/nutritionist_home/form/form.dart';
import 'package:meal_aware/screen/nutritionist_home/message/messageNutritionist.dart';
import 'package:meal_aware/screen/nutritionist_home/profile/profilePageNutritionist.dart';

class NutritionistHome extends StatefulWidget {
  const NutritionistHome({Key? key}) : super(key: key);

  @override
  State<NutritionistHome> createState() => _NutritionistHomeState();
}

class _NutritionistHomeState extends State<NutritionistHome> {
  int _currentIndex = 0;
  final screens = [
    dashboard(),
    messageClient(),
    form(
        url:
            'https://docs.google.com/forms/d/1MESMGRewhTBSFpwVxISOy7dpYpO4V3Ve71sMQKEyqSY/edit'),
    profileNutritionist(),
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
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF989efd), // set navigation bar background color
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.white.withOpacity(0.1),
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Colors.white, width: 1),
              curve: Curves.easeOutExpo,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Message',
                ),
                GButton(
                  icon: Icons.format_list_bulleted,
                  text: 'Form',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
