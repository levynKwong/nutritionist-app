import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/purchase.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/customer_widget.dart/topRightCoinCounter.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class paymentAppointment extends StatefulWidget {
  String nutritionistUid;
  String date;
  List<bool> timeAvailable = [];
  String userId;
  paymentAppointment(
      {super.key,
      required this.nutritionistUid,
      required this.date,
      required this.timeAvailable,
      required this.userId});

  @override
  State<paymentAppointment> createState() =>
      _paymentAppointmentState(nutritionistUid, date, timeAvailable, userId);
}

class _paymentAppointmentState extends State<paymentAppointment> {
  String date;
  List<bool> timeAvailable = [];
  String nutritionistUid;
  String userId;
  _paymentAppointmentState(
      this.nutritionistUid, this.date, this.timeAvailable, this.userId);
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarTopBack(titleText: 'Doctor\'s Forum'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              topSubTitle(width_, height_),
              NutritionistService(width_, height_),
              SizedBox(height: height_ * 0.05),
              content(width_, height_),
              bottomContent(width_, height_)
            ],
          ),
        ),
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(left: width_ * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text5(text: 'payment screen'),
          topRightCounter(),
        ],
      ),
    );
  }

  NutritionistService(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: width_ * 0.9,
              height: height_ * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/pay.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width_ * 0.3, 50),
            primary: Color(0xFF575ecb), // set background color
            onPrimary: Colors.white, // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('        Back       '),
        ),
        SizedBox(width: width_ * 0.1),
        ElevatedButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width_ * 0.03),
                  ),
                  title: Text('Confirm Payment'),
                  content: Text(
                      'Confirm your payment, 1 coin will be deducted from your account'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                        TextButton(
                          onPressed: () {
                            _confirmSelection(timeAvailable);
                            Navigator.of(context).pop();
                            deductCoin(context, nutritionistUid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    )
                  ],
                );
              }),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width_ * 0.3, 50),
            primary: Color(0xFF575ecb), // set background color
            onPrimary: Colors.white, // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/token_.png', // replace this with the path to your image asset
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text('1 coin'),
            ],
          ),
        ),
      ],
    ));
  }

  Widget content(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.05),
            child: Column(
              children: [
                Text(
                  'Read before pressing on the coin',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.052,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 175, 67, 67),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'With 1 Coin you are only paying half of the price, this makes sure that your appointment has been reserved'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you want to change the date of your appointment in the future, contact your nutritionist'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center TermsofUse(double height_, double width_) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Navigate to Terms of Use page
              },
              child: Text(
                'Terms of Use',
                style: TextStyle(
                  color: Color(0xFF7B7B7B),
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' | ',
              style: TextStyle(
                color: Color(0xFF7B7B7B),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Privacy Policy page
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFF7B7B7B),
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomContent(double width_, double height_) {
    return Container(
      child: Column(children: [
        SizedBox(height: height_ * 0.04),
        TermsofUse(height_, width_),
        SizedBox(height: height_ * 0.035),
        buttons(height_, width_)
      ]),
    );
  }

  void _confirmSelection(List<bool> timeAvailable) async {
    List<bool> _selectedTimeSlots = [];

    final selectedTimeSlots = <int>[];
    for (int i = 0; i < timeAvailable.length; i++) {
      if (timeAvailable[i]) {
        selectedTimeSlots.add(i);
      }
    }

    List<int> _getAvailableTimeSlots(List<bool> timeAvailable) {
      final availableTimeSlots = <int>[];
      for (int i = 0; i < timeAvailable.length; i++) {
        if (timeAvailable[i]) {
          availableTimeSlots.add(i);
        }
      }
      return availableTimeSlots;
    }

    if (selectedTimeSlots.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();

      final timeSlotsRef = FirebaseFirestore.instance.collection('timeSlots');

      for (final selectedTimeSlot in selectedTimeSlots) {
        final availableTimeSlots = _getAvailableTimeSlots(timeAvailable);
        if (selectedTimeSlot < availableTimeSlots.length) {
          final index = availableTimeSlots[selectedTimeSlot];

          final docRef = await timeSlotsRef.add({
            'userId': widget.userId,
            'nutritionistId': widget.nutritionistUid,
            'timeSlot': '${index + 6}:00',
          });

          timeAvailable[index] = false;
        }
      }

      batch.update(
        FirebaseFirestore.instance
            .collection('timeAvailability')
            .doc(widget.nutritionistUid),
        {'timesAvailable': timeAvailable},
      );

      await batch.commit();

      setState(() {
        _selectedTimeSlots = List<bool>.filled(timeAvailable.length, false);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Selection confirmed!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select at least one time slot!'),
      ));
    }
  }
}
