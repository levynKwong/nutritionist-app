import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/pendingPlan.dart';
import 'package:collection/collection.dart';


class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarTopCal2(titleText: 'Dashboard'),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height_ * 0.02,
                  ),
                  info(width_, height_),
                  client(width_, height_),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _patientCount = 0;
  int _ClientCount = 0;

  @override
  void initState() {
    super.initState();
    _getPatientCount();
    _clientCounter();
  }

  Future<void> _getPatientCount() async {
    int count = await countPatients();
    if (mounted) {
      setState(() {
        _patientCount = count;
      });
    }
  }

  Future<void> _clientCounter() async {
    int count = await _countDocumentsForToday();
    if (mounted) {
      setState(() {
        _ClientCount = count;
      });
    }
  }

  Future<int> _countDocumentsForToday() async {
    // Create a reference to the pendingPlan collection
    CollectionReference pendingPlan =
        FirebaseFirestore.instance.collection('pendingPlan');

    // Get today's date as a Timestamp object
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

    // Group the documents by id
    Map<String, List<QueryDocumentSnapshot>> groupedDocs =
        groupBy(querySnapshot.docs, (doc) => doc.get('nutritionistId'));

    // Count the number of documents for each id
    int count = 0;
    groupedDocs.forEach((nutritionistId, docs) {
      count += docs.length;
    });

    // Return the count
    return count;
  }

  Future<int> countPatients() async {
    int count = 0;

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('pendingPlan').get();
    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;

    Set<String> uniqueIds = Set<String>();
    for (QueryDocumentSnapshot<Object?> document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String uid = data['nutritionistId'] as String;
      uniqueIds.add(uid);
    }

    count = uniqueIds.length;
    return count;
  }

  Future<List<String>> getPatientUids() async {
    List<String> uids = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('pendingPlan')
        .where('nutritionistId', isEqualTo: currentId)
        .get();
    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;

    for (QueryDocumentSnapshot<Object?> document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String uid = data['userId'] as String;
      uids.add(uid);
    }

    return uids;
  }

  Widget client(double width_, double height_) {
    return SizedBox(
      height: height_ * 0.7,
      width: width_ * 1.3,
      child: Container(
        margin: EdgeInsets.all(width_ * 0.04),
        padding: EdgeInsets.all(width_ * 0.03),
        decoration: BoxDecoration(
          color: Color.fromARGB(207, 36, 146, 146),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 207, 207, 207),
              spreadRadius: 1.5,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: height_ * 0.0),
            Row(
              children: [
                SizedBox(width: width_ * 0.03),
                Text(
                  'Pending Plan',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: width_ * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Plan Type',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: width_ * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: width_ * 0.01,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width_ * 0.03,
                            vertical: height_ * 0.00,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 184, 184, 184),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width_ * 0.008,
                            vertical: height_ * 0.000,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 184, 184, 184),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Appointment',
                                style: TextStyle(fontSize: width_ * 0.03),
                              ),
                              SizedBox(width: width_ * 0.006),
                              Container(
                                width: width_ * 0.032,
                                height: height_ * 0.032,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height_ * 0.01),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Text(
                    'Time/Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Text(
                    'Remove',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: height_ * 0.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: width_ * 0.0025,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: height_ * 0.5,
                child: FutureBuilder<List<String>>(
                  future: getPatientUids(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> patientUids = snapshot.data!;
                      return PendingPlanList(clientUid: patientUids);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(child: Text('Loading...'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width_ * 0.04,
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(189, 46, 191, 191),
                  height: height_ * 0.10,
                  child: Row(
                    children: [
                      Container(
                        width: width_ * 0.07, // set desired width of image
                        height: height_ * 0.035, // set desired height of image
                        child: Image.asset(
                          'images/customer.png', // path to local image file
                          fit: BoxFit.cover,
                          // specify how the image should be resized to fit into the available space
                        ),
                      ),
                      SizedBox(
                        width: width_ * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'Client Counter',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: width_ * 0.026,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$_ClientCount',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: width_ * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Color.fromARGB(255, 232, 232, 232),
                              fontSize: width_ * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width_ * 0.03,
              ),
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromARGB(189, 46, 191, 191),
                    height: height_ * 0.10,
                    child: Row(
                      children: [
                        Container(
                          width: width_ * 0.07, // set desired width of image
                          height: height_ * 0.03, // set desired height of image
                          child: Image.asset(
                            'images/add-group.png', // path to local image file
                            fit: BoxFit.cover,
                            // specify how the image should be resized to fit into the available space
                          ),
                        ),
                        SizedBox(
                          width: width_ * 0.05,
                        ),
                        Column(
                          children: [
                            Text(
                              'Platform Client',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: width_ * 0.026,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' $_patientCount',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: width_ * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Color.fromARGB(255, 232, 232, 232),
                                fontSize: width_ * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                width: width_ * 0.04,
              ),
            ],
          )
        ],
      ),
    );
  }

  

  // Initialize Firebase
}
