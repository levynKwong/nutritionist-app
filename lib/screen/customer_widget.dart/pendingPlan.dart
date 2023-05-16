import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';

class PendingPlanList extends StatefulWidget {
  @override
  _PendingPlanListState createState() => _PendingPlanListState();
}

class _PendingPlanListState extends State<PendingPlanList> {
  List<DocumentSnapshot> _documents = [];

  @override
  void initState() {
    super.initState();
    _queryPendingPlanToday();
  }

  Future<void> _queryPendingPlanToday() async {
    // Create references to the pendingPlan and Patient collections
    CollectionReference pendingPlan =
        FirebaseFirestore.instance.collection('pendingPlan');
    CollectionReference patient =
        FirebaseFirestore.instance.collection('Patient');

    // Get today's date as a string in ISO format (yyyy-MM-dd)
    DateTime today = DateTime.now().toUtc().add(Duration(hours: 4));
    DateTime startOfDay = DateTime(
      today.month,
      today.day,
      today.year,
    );
    DateTime endOfDay =
        DateTime(today.year, today.month, today.day, 23, 59, 59);

    Timestamp startOfToday = Timestamp.fromDate(startOfDay);
    Timestamp endOfToday = Timestamp.fromDate(endOfDay);

    QuerySnapshot querySnapshot = await pendingPlan
        .where('nutritionistId', isEqualTo: currentId)
        .where('date', isGreaterThanOrEqualTo: startOfToday)
        .where('date', isLessThanOrEqualTo: endOfToday)
        .orderBy('date')
        .get();

    setState(() {
      _documents = querySnapshot.docs;
    });

    print('Documents found: ${_documents.length}');
    for (var doc in _documents) {
      print('Document id: ${doc.id}');
      print('Document data: ${doc.data()}');
    }
  }

  Future<void> _handleRefresh() async {
    // Call the _queryPendingPlanToday method to fetch new data
    await _queryPendingPlanToday();
  }

  Future<void> _removeDocument(String documentId) async {
    // Create a reference to the pendingPlan document to remove
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('pendingPlan').doc(documentId);

    // Remove the document from the pendingPlan collection
    await documentReference.delete();

    // Refresh the pending plan list
    await _queryPendingPlanToday();
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    if (_documents.isEmpty) {
      return Center(
        child: Text(
          "No clients today",
          style: TextStyle(fontSize: width_ * 0.045),
        ),
      );
    }
    return ListView.builder(
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        // Get the document snapshot for the current index
        DocumentSnapshot documentSnapshot = _documents[index];

        // Extract the username and timeSlot fields from the document snapshot
        String userId = documentSnapshot.id;
        int timeSlot = documentSnapshot.get('timeSlot');
        String clientId = documentSnapshot.get('userId');
        String timeString = timeSlot == 0
            ? '6:00'
            : timeSlot == 1
                ? '7:00'
                : timeSlot == 2
                    ? '8:00'
                    : timeSlot == 3
                        ? '9:00'
                        : timeSlot == 4
                            ? '10:00'
                            : timeSlot == 5
                                ? '11:00'
                                : timeSlot == 6
                                    ? '12:00'
                                    : timeSlot == 7
                                        ? '13:00'
                                        : timeSlot == 8
                                            ? '14:00'
                                            : timeSlot == 9
                                                ? '15:00'
                                                : timeSlot == 10
                                                    ? '16:00'
                                                    : timeSlot == 11
                                                        ? '17:00'
                                                        : '';
        // Container(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       _handleRefresh();
        //     },
        //     style: ElevatedButton.styleFrom(
        //       primary: Color.fromARGB(0, 0, 0, 0),
        //     ),
        //     child: Icon(Icons.refresh),
        //   ),
        // );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Patient')
                  .doc(clientId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String username = snapshot.data?.get('username');
                  return Text(
                    "$username",
                    style: TextStyle(fontSize: width_ * 0.045),
                  );
                } else {
                  return Text("Loading...");
                }
              },
            ),
            Text(
              "Time: $timeString",
              style: TextStyle(fontSize: width_ * 0.045),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Deletion"),
                      content: Text(
                          "Are you sure you want to delete this appointment?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text("Delete"),
                          onPressed: () {
                            Navigator.pop(context);
                            _removeDocument(userId);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
