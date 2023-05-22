import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_aware/screen/nutritionist_home/dashboard/dashboard.dart';
import 'package:meal_aware/screen/nutritionist_home/form/form.dart';
import 'package:meal_aware/screen/nutritionist_home/message/messageNutritionist.dart';
import 'package:meal_aware/screen/nutritionist_home/profile/profileNutritionist.dart';

class NutritionistHome extends StatefulWidget {
  const NutritionistHome({Key? key}) : super(key: key);

  @override
  State<NutritionistHome> createState() => _NutritionistHomeState();
}

class _NutritionistHomeState extends State<NutritionistHome> {
  int _currentIndex = 0;
  String url = '';
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    fetchEditFormData();
  }

  void fetchEditFormData() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(
            currentId) // Replace 'currentId' with the specific document ID you want to fetch
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Data exists for the given document ID
        Object? data = documentSnapshot.data();
        String? fetchedUrl =
            (data as Map<String, dynamic>)['editForm'] as String?;
        setState(() {
          url = fetchedUrl!;
        });
      }
    }).catchError((error) {
      // Handle any errors that occur during fetching
      print('Error fetching editForm data: $error');
    });
  }

  void initializeScreens() {
    screens = [
      dashboard(),
      messageClient(),
      form(url: url),
      profileNutritionist(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: getColor(), // set navigation bar background color
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width_ * 0.02, vertical: height_ * 0.01),
            child: GNav(
              gap: width_ * 0.01,
              activeColor: Colors.white,
              iconSize: width_ * 0.07,
              padding: EdgeInsets.symmetric(
                  horizontal: width_ * 0.02, vertical: height_ * 0.01),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Colors.white.withOpacity(0.1),
              tabBorderRadius: width_ * 0.03,
              tabActiveBorder: Border.all(color: Colors.white, width: 1),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Message Friend',
                ),
                GButton(
                  icon: Icons.list,
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
