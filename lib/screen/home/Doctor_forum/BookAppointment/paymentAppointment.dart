// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'package:meal_aware/screen/customer_widget.dart/purchaseAppointment.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/topRightCoinCounter.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class paymentAppointment extends StatefulWidget {
  String nutritionistUid;
  String date;
  List<bool> timeAvailable = [];
  String userId;
  String nutritionistName;
  paymentAppointment(
      {super.key,
      required this.nutritionistUid,
      required this.date,
      required this.timeAvailable,
      required this.userId,
      required this.nutritionistName});

  @override
  State<paymentAppointment> createState() => _paymentAppointmentState(
      nutritionistUid, date, timeAvailable, userId, nutritionistName);
}

class _paymentAppointmentState extends State<paymentAppointment> {
  late BuildContext _storedContext;
  @override
  void initState() {
    super.initState();
    _getSelectedTimeSlotsCount(timeAvailable);
    _storedContext = context;
    handleTimeLimit();
  }

  @override
  void dispose() {
    updateLockStatus(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      updateLockStatus(
          false); // Set 'lock' to false when the app goes into the background
    }
  }

  void updateLockStatus(bool newLockStatus) {
    FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(nutritionistUid) // Replace with the actual document ID
        .set({'lock': newLockStatus}, SetOptions(merge: true)).then((_) {
      // Success! Handle navigation or other actions here.
    }).catchError((error) {
      print("Failed to update timeAvailability: $error");
      // Handle error if necessary
    });
  }

  String date;

  List<bool> timeAvailable = [];

  String nutritionistUid;
  String userId;
  String nutritionistName;
  _paymentAppointmentState(this.nutritionistUid, this.date, this.timeAvailable,
      this.userId, this.nutritionistName);

  void handleTimeLimit() {
    Timer(Duration(seconds: 30), () {
      if (Navigator.canPop(_storedContext)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectionDate(
                nutritionistName: nutritionistName,
                nutritionistUid: nutritionistUid),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'This is to prevent user from blocking the time slot for too long.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
           
          ),
        );
      }

      FirebaseFirestore.instance
          .collection('timeAvailability')
          .doc(nutritionistUid) // Replace with the actual document ID
          .set({'lock': false}, SetOptions(merge: true)).then((_) {
        // Navigate to the payment screen
      }).catchError((error) {
        print("Failed to update timeAvailability: $error");
        // Handle error if necessary
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarTopBack(titleText: 'Payment Screen'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              topSubTitle(width_, height_),
              NutritionistService(width_, height_),
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
            child: Container(
              width: width_ * 0.3,
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

  Future<int?> getCoinValue() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();
    if (documentSnapshot.exists) {
      dynamic coinValue = documentSnapshot.get('coin');
      if (coinValue is int) {
        return coinValue;
      } else if (coinValue is String) {
        return int.tryParse(coinValue);
      }
    }
    return 0;
  }

  int timeAvailability = 0;
  String timeRegistered = '';
  void _getSelectedTimeSlotsCount(List<bool> timeAvailable) {
    for (int i = 0; i < timeAvailable.length; i++) {
      if (timeAvailable[i] == false) {
        setState(() {
          timeAvailability = i;
        });
      }
    }
    if (timeAvailability == 0) {
      timeRegistered = "6:00";
    } else if (timeAvailability == 1) {
      timeRegistered = "7:00";
    } else if (timeAvailability == 2) {
      timeRegistered = "8:00";
    } else if (timeAvailability == 3) {
      timeRegistered = "9:00";
    } else if (timeAvailability == 4) {
      timeRegistered = "10:00";
    } else if (timeAvailability == 5) {
      timeRegistered = "11:00";
    } else if (timeAvailability == 6) {
      timeRegistered = "12:00";
    } else if (timeAvailability == 7) {
      timeRegistered = "13:00";
    } else if (timeAvailability == 8) {
      timeRegistered = "14:00";
    } else if (timeAvailability == 9) {
      timeRegistered = "15:00";
    } else if (timeAvailability == 10) {
      timeRegistered = "16:00";
    } else if (timeAvailability == 11) {
      timeRegistered = "17:00";
    }
  }

  Container buttons(double height_, double width_) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              FirebaseFirestore.instance
                  .collection('timeAvailability')
                  .doc(nutritionistUid) // Replace with the actual document ID
                  .set({'lock': false}, SetOptions(merge: true)).then((_) {
                // Navigate to the payment screen
              }).catchError((error) {
                print("Failed to update timeAvailability: $error");
                // Handle error if necessary
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: getColor(context),
              minimumSize: Size(width_ * 0.3, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Back'),
          ),
          SizedBox(width: width_ * 0.1),
          ElevatedButton(
            onPressed: () async {
              int? checkBalance = await getCoinValue();
              if (checkBalance! > 0) {
                showDialog(
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
                                deductCoinAppoinment(context, nutritionistUid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                                FirebaseFirestore.instance
                                    .collection('timeAvailability')
                                    .doc(
                                        nutritionistUid) // Replace with the actual document ID
                                    .set({'lock': false},
                                        SetOptions(merge: true)).then((_) {
                                  // Navigate to the payment screen
                                }).catchError((error) {
                                  print(
                                      "Failed to update timeAvailability: $error");
                                  // Handle error if necessary
                                });
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              } else {
                // Display a message to the user or prevent the dialog from closing
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Insufficient Coins'),
                      content: Text(
                          'You do not have enough coins to make the payment.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: getColor(context),
              minimumSize: Size(width_ * 0.3, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/token_.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Text('1 coin'),
              ],
            ),
          ),
        ],
      ),
    );
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
                          'With 1 Coin you are only reserving the date and time of your appointment.'),
                ),
                SizedBox(height: height_ * 0.01),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'Other additional payment will be held when you meet the nutritionist.'),
                ),
                SizedBox(height: height_ * 0.01),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you want to change the date and time of your appointment in the future, contact your nutritionist'),
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
        TermsAndConditionsDialog(),
        SizedBox(height: height_ * 0.020),
        buttons(height_, width_)
      ]),
    );
  }

  void _confirmSelection(List<bool> timeAvailable) async {
    final selectedTimeSlots = <int>[];
    for (int i = 0; i < timeAvailable.length; i++) {
      if (!timeAvailable[i]) {
        // select only the false values
        selectedTimeSlots.add(i);
      }
    }

    final batch = FirebaseFirestore.instance.batch();
    final docRef = FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.nutritionistUid);

    // Fetch the current timesAvailable array from Firebase
    final docSnapshot = await docRef.get();
    final firebaseTimesAvailable =
        List<bool>.from(docSnapshot.get('timesAvailable'));

    // Update the timesAvailable array in Firebase
    final updatedTimesAvailable = List<bool>.from(firebaseTimesAvailable);
    for (int i = 0; i < timeAvailable.length; i++) {
      if (timeAvailable[i] == true) {
        // Keep the existing value in Firebase
        updatedTimesAvailable[i] = firebaseTimesAvailable[i];
      } else {
        // Update the value in Firebase to false
        updatedTimesAvailable[i] = false;
      }
    }

    batch.update(
      docRef,
      {'timesAvailable': updatedTimesAvailable},
    );

    // Store the selected time slots in the timeSlots collection
    final nutritionistId = widget.nutritionistUid;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final date = DateTime.now();
    for (final timeSlot in selectedTimeSlots) {
      final timeSlotDocRef =
          FirebaseFirestore.instance.collection('timeSlots').doc();
      batch.set(
        timeSlotDocRef,
        {
          'nutritionistId': nutritionistId,
          'timeSlot': timeSlot,
          'userId': userId,
          'date': date,
        },
      );
    }
    for (final timeSlot in selectedTimeSlots) {
      final timeSlotDocRef =
          FirebaseFirestore.instance.collection('pendingPlan').doc();
      batch.set(
        timeSlotDocRef,
        {
          'nutritionistId': nutritionistId,
          'timeSlot': timeSlot,
          'date': date,
          'userId': userId,
        },
      );
    }
    try {
      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Your appointment has been set with the nutritionist today at $timeRegistered, please check your purchase history for more details'),
      ));
      NotificationService.showNotification(
        title: 'Appointment Set',
        body: 'Meet your nutritionist today at $timeRegistered',
      );
    } catch (e) {
      print('Error while committing batch: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error confirming selection'),
      ));
    }
  }
}
