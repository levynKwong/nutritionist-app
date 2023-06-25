import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_aware/screen/nutritionist_home/dashboard/dashboard.dart';
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
  late PageController _pageController;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);
    fetchEditFormData();
  
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void fetchEditFormData() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId) // Replace 'currentId' with the specific document ID you want to fetch
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



  List<Widget> get screens {
    return [
      dashboard(),
      messageClient(),
      // form(url: url),
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
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: screens,
          ),
          UpgradeAlert(
            upgrader: Upgrader(
              shouldPopScope: () => true,
              canDismissDialog: false,
              dialogStyle: UpgradeDialogStyle.material,
              debugDisplayAlways: true,
              showIgnore: false,
              showLater:false,
              durationUntilAlertAgain: Duration(days: 1),
            ),
            child: Container(), // Replace with your content
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary, // set navigation bar background color
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8)
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width_ * 0.02, vertical: height_ * 0.01),
            child: GNav(
              gap: width_ * 0.01,
              activeColor: getColor(context),
              iconSize: width_ * 0.07,
              padding: EdgeInsets.symmetric(
                  horizontal: width_ * 0.02, vertical: height_ * 0.01),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Colors.white.withOpacity(0.1),
              tabBorderRadius: width_ * 0.03,
              tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
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
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
