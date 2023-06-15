import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/home/Message/message.dart';
import 'package:meal_aware/screen/home/MessageNutritionit/messageNutritionist.dart';
import 'package:meal_aware/screen/home/profile/profilePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final screens = [
    messageNutritionist(),
    message(),
    DoctorForum(),
    profile(),
  ];
  final PageController _pageController = PageController();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    initMessaging();
  }

  void initMessaging() async {
    await _firebaseMessaging.requestPermission();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? ''),
          content: Text(message.notification?.body ?? ''),
          actions: [
            TextButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: redirectToPlayStore,
            ),
          ],
        ),
      );
    });
  }

  void redirectToPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.mealAware.app.package'; // Replace with your app's Play Store URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
              tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.tertiary, width: 1),
              tabs: [
                GButton(
                  icon: Icons.book,
                  text: 'Message Doctor',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Message Friend',
                ),
                GButton(
                  icon: Icons.face,
                  text: 'Doctor Forum',
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
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
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
