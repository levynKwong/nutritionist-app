import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key});

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopBack(
        titleText: 'Purchase History',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('pid', isEqualTo: currentId)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No purchase history found.'),
            );
          }

          double totalAmount = 0;

          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            int amount = data['amount'];
            totalAmount += amount;
          });

          return Column(
            children: [
              ListTile(
                title: Text('Total Amount'),
                subtitle: Text(totalAmount.toString()),
              ),
              Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    int amount = data['amount'];

                    String nid = data['nid'];
                    Timestamp timestamp = data['date'];
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
                            title: Text('Amount: $amount'),
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
                            title: Text('Amount: $amount'),
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

                        return ListTile(
                          title: Text('Amount: $amount'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: $day/$month/$year'),
                              Text('Username: Dr. $username'),
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
