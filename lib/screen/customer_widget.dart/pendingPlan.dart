import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/moreInfoDashboardList.dart';

class PendingPlanList extends StatefulWidget {
  final List<String> clientUid;

  PendingPlanList({required this.clientUid});

  @override
  _PendingPlanListState createState() => _PendingPlanListState(clientUid);
}

class _PendingPlanListState extends State<PendingPlanList> {
  final List<String> clientUid;
  _PendingPlanListState(this.clientUid);

  List<DocumentSnapshot> _documents = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _listenForPendingPlanUpdates();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _listenForPendingPlanUpdates() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Calculate the start and end of today
    DateTime startOfToday = DateTime(now.month, now.day, now.year);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // Create a query with the desired filters
    Query query = FirebaseFirestore.instance
        .collection('pendingPlan')
        .where('nutritionistId', isEqualTo: currentId)
        .where('date', isGreaterThanOrEqualTo: startOfToday)
        .where('date', isLessThanOrEqualTo: endOfToday)
        .orderBy('date');

    // Subscribe to real-time updates
    _subscription = query.snapshots().listen((querySnapshot) {
      _documents = querySnapshot.docs;
      print('Documents found: ${_documents.length}');
      for (var doc in _documents) {
        print('Document id: ${doc.id}');
        print('Document data: ${doc.data()}');
      }
    });
  }

  Future<void> _removeDocument(String documentId) async {
    // Create a reference to the pendingPlan document to remove
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('pendingPlan').doc(documentId);

    // Remove the document from the pendingPlan collection6
    await documentReference.delete();
    setState(() {
      _documents.removeWhere((doc) => doc.id == documentId);
    });
    // No need to manually refresh the data as the real-time updates will handle it
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;

    if (_documents.isEmpty) {
      return Center(
        child: Text(
          "No clients today",
          style: TextStyle(fontSize: width_ * 0.045),
        ),
      );
    }

    // Sort the documents based on timeSlot in ascending order
    _documents.sort((a, b) => a.get('timeSlot').compareTo(b.get('timeSlot')));

    return ListView.builder(
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        DocumentSnapshot documentSnapshot = _documents[index];
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

        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MoreInfoDashboardList(friendId: [clientId]);
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 219, 219, 219),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
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
                        style: TextStyle(
                            fontSize: width_ * 0.045,
                            color: Colors.black,
                        ),
                      );
                    } else {
                      return Text("Loading...");
                    }
                  },
                ),
                Text(
                  "$timeString",
                  style: TextStyle(
                      fontSize: width_ * 0.045,
                      color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.close,
                      color: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text(
                            "Are you sure you want to delete this appointment?",
                          ),
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
            ),
          ),
        );
      },
    );
  }
}
