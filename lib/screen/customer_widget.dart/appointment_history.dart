import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';

class appointmentHistory extends StatefulWidget {
  const appointmentHistory({Key? key});

  @override
  _appointmentHistoryState createState() => _appointmentHistoryState();
}

class _appointmentHistoryState extends State<appointmentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopBack(
        titleText: 'Appointment History',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('timeSlots')
            .where('userId',isEqualTo: currentId)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
            child:Text('Error: ${snapshot.error}')
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
            child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
             child: Text('No purchase history found.'),
             );
          }

          return Column(
            children: [
              ListTile(
                title: Text('Appointment Details'),
                subtitle: Text(
                    'If you want to cancel your appointment or change the date and time, please contact your nutritionist.'),
              ),
              Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    // int amount = data['amount'];

                    String nid = data['nutritionistId'];
                    Timestamp timestamp = data['date'];
                    int timeSlot = data['timeSlot'] + 6;
                    DateTime dateTime = timestamp.toDate();
                    String day = '${dateTime.day}';
                    String month = '${dateTime.month}';
                    String year = '${dateTime.year}';

                    // Retrieve the username from the "Nutritionist" collection
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Nutritionist')
                          .doc(nid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot>
                              nutritionistSnapshot) {
                        if (nutritionistSnapshot.hasError) {
                          return Text('Error: ${nutritionistSnapshot.error}');
                        }

                        if (nutritionistSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListTile(
                            // title: Text('Amount: $amount'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: $day/$month/$year'),
                                Text('Username: Loading...'),
                              ],
                            ),
                          );
                        }

                        if (!nutritionistSnapshot.hasData ||
                            !nutritionistSnapshot.data!.exists) {
                          return ListTile(
                            // title: Text('Amount: $amount'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: $day/$month/$year'),
                                Text('Username: Not found'),
                              ],
                            ),
                          );
                        }

                        // Username found in the "Nutritionist" collection
                        String username = (nutritionistSnapshot.data!.data()
                                as Map<String, dynamic>)['username'] ??
                            '';
                        String address = (nutritionistSnapshot.data!.data()
                                as Map<String, dynamic>)['address'] ??
                            '';
                        String phone = (nutritionistSnapshot.data!.data()
                                as Map<String, dynamic>)['phoneNumber'] ??
                            '';
                        String email = (nutritionistSnapshot.data!.data()
                                as Map<String, dynamic>)['email'] ??
                            '';
                        return ListTile(
                          // title: Text('Amount: $amount'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: $day/$month/$year'),
                              Text('Time Slot: $timeSlot:00'),
                              Text('Username: Dr. $username'),
                              Text('Address: $address'),
                              Text('Phone: $phone'),
                              Text('Email: $email'),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
