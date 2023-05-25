import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'package:meal_aware/screen/customer_widget.dart/purchase.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/topRightCoinCounter.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/WebViewScreen.dart';

class paymentChat extends StatefulWidget {
  final String nid;
  final String nutritionistName;
  const paymentChat(
      {Key? key, required this.nutritionistName, required this.nid})
      : super(key: key);

  @override
  State<paymentChat> createState() => _paymentChatState(nutritionistName, nid);
}

class _paymentChatState extends State<paymentChat> {
  String nutritionistName;
  String nid;
  String url = '';
  _paymentChatState(this.nutritionistName, this.nid);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _email = '';
  @override
  void initState() {
    super.initState();

    getEmail().then((email) {
      setState(() {
        _email = email;
      });
    });
    checkIfPaymentExists();
    fetchEditFormData();
  }

  void fetchEditFormData() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(
            nid) // Replace 'currentId' with the specific document ID you want to fetch
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Data exists for the given document ID
        Object? data = documentSnapshot.data();
        String? fetchedUrl =
            (data as Map<String, dynamic>)['patientForm'] as String?;
        setState(() {
          url = fetchedUrl!;
        });
      }
    }).catchError((error) {
      // Handle any errors that occur during fetching
      print('Error fetching editForm data: $error');
    });
  }

  Future<bool> checkIfPaymentExists() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('payments')
        .where('nid', isEqualTo: nid)
        .where('pid', isEqualTo: currentId)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isNotEmpty;
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

  Future<int?> getProgressValue() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('nid', isEqualTo: nid)
        .where('pid', isEqualTo: currentId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      dynamic progressValue = querySnapshot.docs[0].get('progress');
      if (progressValue is int) {
        return progressValue;
      } else if (progressValue is String) {
        return int.tryParse(progressValue);
      }
    }
    return 0;
  }

  Future<String> getEmail() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('email');
    } else {
      return 'email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: appBarTop(titleText: 'Payment'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              topSubTitle(width_, height_),
              NutritionistService(width_, height_),
              SizedBox(height: height_ * 0.02),
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
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => (selectionDate()),
              //   ),
              // );
            },
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

  bool isConfirmButtonEnabled = true;

  Container buttons(double height_, double width_) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF575ecb),
              minimumSize: Size(width_ * 0.3, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Back'),
          ),
          SizedBox(width: width_ * 0.1),
          ElevatedButton(
            onPressed: isConfirmButtonEnabled
                ? () async {
                    setState(() {
                      isConfirmButtonEnabled = false; // Disable the button
                    });

                    int? checkBalance = await getCoinValue();
                    int? progress = await getProgressValue();

                    bool paymentExists = await checkIfPaymentExists();
                    print('progressValue: $progress');

                    if (paymentExists && progress == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Already added'),
                            content: Text(
                                'You have already added this nutritionist to your list, please go to your list to chat with them. If you have reached your subscription limit, please upgrade your subscription by going to the nutritionist page, click on the locked send button and proceed to upgrade your subscription.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (checkBalance! > 0 && progress == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            url: url,
                            email: _email,
                            nid: nid,
                            nutritionistName: nutritionistName,
                          ),
                        ),
                      );
                      deductCoin(context, nid);
                      NotificationService.showNotification(
                        title: 'Chat doctor',
                        body:
                            'Purchase successful, you can now chat with your nutritionist.',
                      );
                    } else if (progress == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            url: url,
                            email: _email,
                            nid: nid,
                            nutritionistName: nutritionistName,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Insufficient coins'),
                            content: Text(
                                'You do not have enough coins to make this payment, please purchase more coins.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                : null, // Disable the button if isConfirmButtonEnabled is false
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF575ecb),
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
                    fontSize: MediaQuery.of(context).size.width * 0.042,
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
                          'With 1 Coin you can chat with your nutritionist for 1 week. You can purchase more coins in the future if you want to continue chatting with your nutritionist.'),
                ),
                SizedBox(height: height_ * 0.03),
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
}
