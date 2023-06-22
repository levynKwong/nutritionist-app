import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:intl/intl.dart';

class clientHistoryAppointment extends StatefulWidget {
  const clientHistoryAppointment({super.key});

  @override
  _clientHistoryAppointmentState createState() =>
      _clientHistoryAppointmentState();
}

class _clientHistoryAppointmentState extends State<clientHistoryAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopBack(
        titleText: 'Client History Appointment',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('paymentAppointment')
            .orderBy('nid')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
            child:Text('Error: ${snapshot.error}')
          );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
            child:CircularProgressIndicator()
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
            child:Text('No purchase history found.')
            );
          }

          double totalAmount = 0;

          DateTime now = DateTime.now();
          int currentMonth = now.month;
          int currentYear = now.year;

          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String pid = data['pid'];
            int amount = data['amount'];
            Timestamp timestamp = data['date'];
            DateTime dateTime = timestamp.toDate();
            int paymentMonth = dateTime.month;
            int paymentYear = dateTime.year;

            if (paymentMonth == currentMonth && paymentYear == currentYear) {
              totalAmount += amount;
            }
          });

          final currencyFormat =
              NumberFormat.currency(locale: 'en_US', symbol: ' Coin');
          String formattedTotalAmount = currencyFormat.format(totalAmount);

          return Column(
            children: [
              ListTile(
                title: Text('Total amount for this month'),
                subtitle: Text(formattedTotalAmount),
              ),
              Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    int amount = data['amount'];
                    Timestamp timestamp = data['date'];
                    DateTime dateTime = timestamp.toDate();
                    String day = '${dateTime.day}';
                    String month = '${dateTime.month}';
                    String year = '${dateTime.year}';
                    String pid = data['pid'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(pid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String username = snapshot.data?.get('username');
                          String fullname = snapshot.data?.get('fullname');
                          String email = snapshot.data?.get('email');
                          String phone = snapshot.data?.get('phoneNumber');
                          return ListTile(
                            title: Text('Amount: $amount'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: $day/$month/$year'),
                                Text('Username: $username'),
                                Text('Fullname: $fullname'),
                                Text('Email: $email'),
                                Text('Phone: $phone'),
                              ],
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Text('Amount: $amount'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: $day/$month/$year'),
                                Text('Username: Loading...'),
                                Text('Fullname: Loading...'),
                              ],
                            ),
                          );
                        }
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
