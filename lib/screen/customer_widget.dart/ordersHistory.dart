import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

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
            .orderBy('pid')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Text('No purchase history found.');
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
                    Timestamp timestamp = data['date'];
                    DateTime dateTime = timestamp.toDate();
                    String day = '${dateTime.day}';
                    String month = '${dateTime.month}';
                    String year = '${dateTime.year}';

                    return ListTile(
                      title: Text('Amount: $amount'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: $day/$month/$year'),
                        ],
                      ),
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
