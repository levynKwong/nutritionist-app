import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/Doctor_forum/doctor_forum.dart';
import 'package:meal_aware/screen/home/Message/message.dart';
import 'package:meal_aware/screen/home/MessageNutritionit/messageNutritionist.dart';
import 'package:meal_aware/screen/home/profile/profilePage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late AuthorizationStatus notificationPermission;

  @override
  void initState() {
    super.initState();
    initMessaging();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkNotificationPermission();
    }
  }

  Future<void> initMessaging() async {
    checkNotificationPermission();
  }

  Future<void> checkNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    setState(() {
      notificationPermission = settings.authorizationStatus;
    });

    if (notificationPermission == AuthorizationStatus.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification Permission Denied'),
            content: Text(
              'Please enable notification permissions for this app in your device settings to receive notifications.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Check notification permission after the dialog is dismissed
                  checkNotificationPermission();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('User granted permission: $notificationPermission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });
    }
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
              activeColor: Color.fromARGB(255, 255, 255, 255),
              iconSize: width_ * 0.07,
              padding: EdgeInsets.symmetric(
                  horizontal: width_ * 0.02, vertical: height_ * 0.01),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor:
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              tabBorderRadius: width_ * 0.03,
              tabActiveBorder: Border.all(color: Colors.white, width: 1),
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
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
