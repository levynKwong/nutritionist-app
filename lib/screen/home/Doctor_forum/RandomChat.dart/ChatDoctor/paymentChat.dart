import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
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
  }

  Future<bool> checkIfPaymentExists() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('payments')
        .where('nid', isEqualTo: nid)
        .where('pid', isEqualTo: userId)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isNotEmpty;
  }

  Future<int?> getCoinValue() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
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

  Future<String> getEmail() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
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
              width: width_ * 0.35,
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

  Container buttons(double height_, double width_) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF575ecb),
            minimumSize: Size(width_ * 0.3, 50), // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('        Back       '),
        ),
        SizedBox(width: width_ * 0.1),
        ElevatedButton(
          onPressed: () => showDialog(
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
                          onPressed: () async {
                            bool paymentExists = await checkIfPaymentExists();

                            if (paymentExists) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Already added'),
                                    content: Text(
                                        'You have already added this nutritionist to your list, please go to your list to chat with them. If you have reached your subscription limit, please upgrade your subscription by going to the nutritionitst page, click on the send button that is locked and proceed to upgrade your subscription.'),
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
                            } else {
                              int? checkBalance = await getCoinValue();
                              if (checkBalance! > 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                      url:
                                          'https://docs.google.com/forms/d/e/1FAIpQLSc2N93MQzP1v6aCjTadB393l8Q8_9F2P0489kXykYjtnpcuzg/viewform?usp=sf_link',
                                      email: _email,
                                      nid: nid,
                                      nutritionistName: nutritionistName,
                                    ),
                                  ),
                                );
                                deductCoin(context, nid);
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
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    )
                  ],
                );
              }),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF575ecb),
            minimumSize: Size(width_ * 0.3, 50), // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/token_.png', // replace this with the path to your image asset
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text('1 coin'),
            ],
          ),
        ),
      ],
    ));
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
                          'With 1 Coin you are only paying half of the price, this makes sure that your appointment has been reserved'),
                ),
                SizedBox(height: height_ * 0.03),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text8(
                      text:
                          'If you want to change the date of your appointment in the future, contact your nutritionist'),
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
        SizedBox(height: height_ * 0.04),
        TermsofUse(height_, width_),
        SizedBox(height: height_ * 0.035),
        buttons(height_, width_)
      ]),
    );
  }
}
