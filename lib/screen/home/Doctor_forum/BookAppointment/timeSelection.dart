import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/NutritionistBookApp.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/paymentAppointment.dart';

class TimeAvailabilityScreen extends StatefulWidget {
  final String userId;
  final String nutritionistId;
  final String date;
  final now = DateTime.now();
  final String nutritionistName;

  TimeAvailabilityScreen(
      {required this.userId,
      required this.nutritionistId,
      required this.date,
      required this.nutritionistName});

  @override
  _TimeAvailabilityScreenState createState() => _TimeAvailabilityScreenState(
      userId, nutritionistId, date, nutritionistName);
}

class _TimeAvailabilityScreenState extends State<TimeAvailabilityScreen> {
  final String userId;
  final String nutritionistId;
  final String date;
  final String nutritionistName;
  _TimeAvailabilityScreenState(
      this.userId, this.nutritionistId, this.date, this.nutritionistName);
  late Stream<List<bool>> _timeAvailabilityStream;
  List<bool> _selectedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    startPaymentStatusChecker();
    _timeAvailabilityStream = FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.nutritionistId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null && data['timesAvailable'] != null) {
        return List<bool>.from(data['timesAvailable']);
      } else {
        return <bool>[];
      }
    });
    _selectedTimeSlots = List<bool>.filled(_selectedTimeSlots.length, false);
  }

  Future<void> startPaymentStatusChecker() async {
    final now = DateTime.now();
    final sixtySec = now.subtract(Duration(seconds: 60));

    // Function to perform the payment status check
    Future<void> performPaymentStatusCheck() async {
      try {
        await FirebaseFirestore.instance
            .collection('timeAvailability')
            .doc(nutritionistId) // Replace with the actual document ID
            .set({'lock': false}, SetOptions(merge: true));

        final querySnapshot = await FirebaseFirestore.instance
            .collection('timeAvailability')
            .doc(nutritionistId) // Replace with the actual document ID
            .get();

        if (querySnapshot.exists) {
          final doc = querySnapshot.data();
          DateTime timeDate = doc?['time'].toDate();
          if (timeDate.isBefore(sixtySec)) {
            await FirebaseFirestore.instance
                .collection('timeAvailability')
                .doc(nutritionistId)
                .update({'lock': false});

            print('Lock status updated to false');
          }
        }
      } catch (error) {
        // Handle error during payment status check
        print('Error checking payment status: $error');
      }
    }

    // Perform initial payment status check
    await performPaymentStatusCheck();

    // Periodically perform payment status check every 2 hours
  }

  void _toggleSelection(int index) {
    setState(() {
      for (int i = 0; i < _selectedTimeSlots.length; i++) {
        if (i == index) {
          _selectedTimeSlots[i] = false;
        } else {
          _selectedTimeSlots[i] = true;
        }
      }
    });
  }

  List<int> _getAvailableTimeSlots(List<bool> timeAvailable) {
    final availableTimeSlots = <int>[];
    for (int i = 0; i < timeAvailable.length; i++) {
      availableTimeSlots.add(i);
    }
    return availableTimeSlots;
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height_ * 0.40,
          child: Center(
            child: StreamBuilder<List<bool>>(
              stream: _timeAvailabilityStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final timeAvailable = snapshot.data!;
                if (_selectedTimeSlots.length != timeAvailable.length) {
                  _selectedTimeSlots =
                      List<bool>.filled(timeAvailable.length, false);
                }
                if (timeAvailable.isEmpty) {
                  return Text('No time slots available');
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: Wrap(
                          runSpacing: 0.0, // set space between rows
                          children: List.generate(
                            _getAvailableTimeSlots(timeAvailable).length,
                            (index) {
                              final isSelected = _selectedTimeSlots[index];
                              final availableIndex =
                                  _getAvailableTimeSlots(timeAvailable)[index];
                              final timeSlot = ' ${availableIndex + 6}:00';
                              return SizedBox(
                                width: width_ * 0.3, // set width of button
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: width_ * 0.01),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (timeAvailable[_getAvailableTimeSlots(
                                          timeAvailable)[index]]) {
                                        _toggleSelection(index);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                        (states) {
                                          if (isSelected) {
                                            return Colors.grey;
                                          } else {
                                            // If the corresponding boolean value in _selectedTimeSlots is false, disable the button and set its color to grey.
                                            if (!timeAvailable[
                                                _getAvailableTimeSlots(
                                                    timeAvailable)[index]]) {
                                              return Color.fromARGB(
                                                  255, 168, 72, 72);
                                            } else {
                                              return getColor(context);
                                            }
                                          }
                                        },
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(60, 30)),
                                    ),
                                    child: Text(
                                      timeSlot,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      buttons(height_, width_),
                      SizedBox(height: height_ * 0.02),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buttons(double height_, double width_) {
    bool isTimeSlotSelected = _selectedTimeSlots.contains(true);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NutritionistBookAppointment()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: getColor(context),
              minimumSize: Size(width_ * 0.3, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Back'),
          ),
          SizedBox(width: width_ * 0.15),
          ElevatedButton(
            onPressed: isTimeSlotSelected
                ? () {
                    // Check lock status
                    FirebaseFirestore.instance
                        .collection('timeAvailability')
                        .doc(
                            nutritionistId) // Replace with the actual document ID
                        .get()
                        .then((snapshot) {
                      if (snapshot.exists && snapshot.data()?['lock'] == true) {
                        // Show dialog box indicating that the user is making a payment
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Payment in Progress"),
                              content: Text(
                                  "Please wait while the a user completes the payment. This is to make sure the is no conflict in the appointment time. Please wait for a few seconds and try again."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Update Firebase collection to set 'lock' to true
                        FirebaseFirestore.instance
                            .collection('timeAvailability')
                            .doc(
                                nutritionistId) // Replace with the actual document ID
                            .set({
                          'lock': true,
                          'time': FieldValue.serverTimestamp(),
                        }, SetOptions(merge: true)).then((_) {
                          // Success! Handle navigation or other actions here.

                          // Navigate to the payment screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => paymentAppointment(
                                nutritionistUid: nutritionistId,
                                userId: currentId,
                                date: date,
                                timeAvailable: _selectedTimeSlots,
                                nutritionistName: nutritionistName,
                              ),
                            ),
                          );
                        }).catchError((error) {
                          print("Failed to update timeAvailability: $error");
                          // Handle error if necessary
                        });
                      }
                    }).catchError((error) {
                      print("Failed to fetch timeAvailability: $error");
                      // Handle error if necessary
                    });
                  }
                : null, // Disable the button if no time slot is selected
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: getColor(context),
              minimumSize: Size(width_ * 0.3, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
