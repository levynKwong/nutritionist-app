import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/BuyCoin.dart';

class GetCoin extends StatefulWidget {
  const GetCoin({super.key});

  @override
  State<GetCoin> createState() => _GetCoinState();
}

class _GetCoinState extends State<GetCoin> {
  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());

  int selectedRadio = 0;
  Future<bool> validateCodeAndUpdateExpectedCodes(String enteredCode) async {
    final CollectionReference codesCollection =
        FirebaseFirestore.instance.collection('couponCodes');

    try {
      // Get the document reference for the entered code
      final QuerySnapshot codesSnapshot =
          await codesCollection.where('code', isEqualTo: enteredCode).get();
      final DocumentReference? enteredCodeRef = codesSnapshot.docs.isNotEmpty
          ? codesSnapshot.docs.first.reference
          : null;

      if (enteredCodeRef != null) {
        // Delete the entered code document from the collection
        await enteredCodeRef.delete();
        print('Removed $enteredCode from expected codes');
        return true; // Code is valid and has been removed from expected codes
      } else {
        print(
            'Error: $enteredCode does not exist in expected codes collection');
        return false; // Code is invalid
      }
    } catch (e) {
      print('Error removing $enteredCode from expected codes: $e');
      return false; // Code is invalid due to error
    }
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          background(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    topBar(width_, height_, context),
                    SizedBox(height: height_ * 0.02),
                    CoinCounter(),
                    SizedBox(height: height_ * 0.02),
                    Container(
                      margin: EdgeInsets.only(
                        left: width_ * 0.1,
                        right: width_ * 0.1,
                      ),
                      child: Text4(
                        text:
                            'You can use the coins to allow to communicate with your nutritionist and book appointments with them.',
                      ),
                    ),
                    SizedBox(height: height_ * 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width_ * 0.1,
                      ),
                      child: Text3(
                        text: 'Enter Your Coupon Code:',
                      ),
                    ),
                    SizedBox(height: height_ * 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width_ * 0.1,
                      ),
                      child: confirmationCode(width_, height_),
                    ),
                    SizedBox(height: height_ * 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width_ * 0.1,
                      ),
                      child: Text5(
                        text:
                            'After confirmation, please wait for your coin to be updated, while it is updating you can go to your Home Screen',
                      ),
                    ),
                    SizedBox(height: height_ * 0.02),
                  TermsAndConditionsDialog(),
                    SizedBox(height: height_ * 0.02),
                    buttons(height_, width_),
                  ],
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
          primary: Color(0xFF575ecb), // set background color
          onPrimary: Colors.white, // set text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('    Back    '),
      ),

        SizedBox(width: width_ * 0.15), // add some spacing between the buttons
        ElevatedButton(
          onPressed: () async {
            String enteredCode =
                _textControllers.map((controller) => controller.text).join("");

            if (await validateCodeAndUpdateExpectedCodes(enteredCode)) {
              _updateUserCoinCount(1);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Code already used')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF575ecb), // set text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Confirm'),
        ),
      ],
    ));
  }

  // Center TermsofUse(double height_, double width_) {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TextButton(
  //             onPressed: () {
  //               TermsAndConditionsDialog();
  //             },
  //             child: Text(
  //               'Terms of Use',
  //               style: TextStyle(
  //                 color: Color(0xFF7B7B7B),
  //                 // decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             ' | ',
  //             style: TextStyle(
  //               color: Color(0xFF7B7B7B),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Navigate to Privacy Policy page
  //             },
  //             child: Text(
  //               'Privacy Policy',
  //               style: TextStyle(
  //                 color: Color(0xFF7B7B7B),
  //                 // decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget topBar(double width_, double height_, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        Row(
          children: [
            Image.asset(
              'images/tokenIcon.png',
              height: height_ * 0.1,
              width: width_ * 0.1,
            ),
            SizedBox(
              width: width_ * 0.08,
            ),
            Text3(text: 'Get Coin')
          ],
        ),
        SizedBox(
          width: width_ * 0.09,
        ),
      ],
    );
  }

  Widget confirmationCode(double width_, double height_) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          SizedBox(
            width: width_ * 0.12,
            height: height_ * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width_ * 0.009),
              child: TextField(
                controller: _textControllers[i],
                maxLength: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: height_ * 0.025),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
      ],
    );
  }

  void _updateUserCoinCount(int coinsToAdd) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    // Get the user document reference
    final userDoc = FirebaseFirestore.instance.collection('Patient').doc(uid);

    try {
      // Use a transaction to update the user's coin count
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the current user document snapshot
        final userSnapshot = await transaction.get(userDoc);

        // Get the current coin count
        final currentCoins = userSnapshot.data()!['coin'] ?? 0;

        // Calculate the new coin count
        final newCoins = currentCoins + coinsToAdd;

        // Update the user document with the new coin count
        transaction.update(userDoc, {'coin': newCoins});
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Coins added successfully!')),
      );
      NotificationService.showNotification(
        title: 'Coupon Code',
        body:
            'You have successfully redeemed a coupon code. You have been awarded 1 coin.',
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code already used: $e')),
      );
    }
  }
}
