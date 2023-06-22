import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/GetCoin.dart';

class BuyCoin extends StatefulWidget {
  const BuyCoin({Key? key}) : super(key: key);

  @override
  State<BuyCoin> createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static const String coinId1 = 'coin_1_mealaware';
  static const String coinId2 = 'coin_2_mealaware';
  static const String coinId3 = 'coin_3_mealaware';
  static const List<String> _kProductIds = <String>[
    coinId1,
    coinId2,
    coinId3,
  ];
  static const bool _kAutoConsume = true;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      handleError(error as IAPError);
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailsResponse.error != null) {
      setState(() {
        _queryProductError = productDetailsResponse.error!.message;
        _loading = false;
      });
      return;
    }

    if (productDetailsResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = 'No products available for purchase';
        _loading = false;
      });
      return;
    }

    setState(() {
      _products = productDetailsResponse.productDetails;
      _notFoundIds = productDetailsResponse.notFoundIDs;
      _loading = false;
    });
  }

 Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList) async {
  for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      showPendingUI();
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        final bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          unawaited(deliverProduct(purchaseDetails));
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }
}


  void showPendingUI() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(), // Circular loading indicator
                SizedBox(height: 16.0),
                Text(
                  'Processing...',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleError(IAPError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong')),
    );
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // TODO: Implement your own verification logic
    // Verify the purchase and return a boolean indicating whether it's valid
    return true; // Replace with your own verification logic
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // TODO: Implement product delivery logic
    // Deliver the purchased product to the user
    // For example, you can grant the user the purchased coins
    final String productID = purchaseDetails.productID;
    if (_kProductIds.contains(productID)) {
      if (productID == coinId1) {
        _updateUserCoinCount(1);
      } else if (productID == coinId2) {
        _updateUserCoinCount(2);
      } else if (productID == coinId3) {
        _updateUserCoinCount(3);
      }
    }
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
        title: 'Payment Successful',
        body: 'You have successfully purchased $coinsToAdd coins!',
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid Purchase')),
    );
  }

  Widget buttons(double height_, double width_) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height_ * 0.02),
            CoinCounter(),
            SizedBox(height: height_ * 0.02),
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: width_ * 0.02,
                      right: width_ * 0.02,
                    ),
                    child: Text4(
                      text:
                          'You can use the coins to allow to communicate with your nutritionist and book appointments with them.\n\n After purchase, it takes time for the coin to load, in the mean time you can use the app as usual.',
                    ),
                  ),
                  SizedBox(height: height_ * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      _inAppPurchase.buyNonConsumable(
                        purchaseParam:
                            PurchaseParam(productDetails: _products[0]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/token1.png',
                          width: width_ * 0.07,
                          height: height_ * 0.06,
                        ),
                        SizedBox(width: width_ * 0.17),
                        Text('Buy 1 coin'),
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.015),
                  ElevatedButton(
                    onPressed: () {
                      _inAppPurchase.buyNonConsumable(
                        purchaseParam:
                            PurchaseParam(productDetails: _products[1]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/token2.png',
                          width: width_ * 0.09,
                          height: height_ * 0.06,
                        ),
                        SizedBox(width: width_ * 0.15),
                        Text('Buy 2 coins'),
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.015),
                  ElevatedButton(
                    onPressed: () {
                      _inAppPurchase.buyNonConsumable(
                        purchaseParam:
                            PurchaseParam(productDetails: _products[2]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/token3.png',
                          width: width_ * 0.1,
                          height: height_ * 0.06,
                        ),
                        SizedBox(width: width_ * 0.14),
                        Text('Buy 3 coins'),
                      ],
                    ),
                  ),
                  TermsAndConditionsDialog(),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  getColor(context), // set background color
                             // set text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('    Back    '),
                          ),
                        ),
                        SizedBox(
                            width: width_ * 0.1), // Add spacing between buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetCoin(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  getColor(context), // set background color
                              // set text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Coupons'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_queryProductError != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: getColor(context),
        ),
        body: Center(
          child: Text('Failed to load products: $_queryProductError'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Coins'),
        backgroundColor: getColor(context),
      ),
      body: buttons(height, width),
    );
  }
}



// goog_JOqwYSmDCvNhYRFmMfOVybysoDu
 // Widget buildRadioTile({
  //   required int value,
  //   required Image image,
  //   required Widget title,
  //   required double imageSize,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       color: Color(0xFFa0b1f9),
  //     ),
  //     height: 60,
  //     child: RadioListTile(
  //       value: value,
  //       groupValue: selectedRadio,
  //       onChanged: (val) {
  //         print('number $val');
  //         setSelectedRadio(val!);
  //       },
  //       controlAffinity: ListTileControlAffinity.trailing,
  //       activeColor: Color(0xFF575dcb),
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             width: imageSize,
  //             height: imageSize,
  //             child: image,
  //           ),
  //           SizedBox(width: 26),
  //           Flexible(child: title),
  //         ],
  //       ),
  //     ),
  //   );
  // }




  // Widget selectionButton(double height_, double width_) {
  //   return Center(
  //     child: Container(
  //       child: Container(
  //         width: width_ * 0.8,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             buildRadioTile(
  //               value: 1,
  //               image: Image.asset('images/token1.png'),
  //               title: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
  //               imageSize: width_ * 0.11,
  //             ),
  //             SizedBox(height: height_ * 0.02),
  //             buildRadioTile(
  //               value: 2,
  //               image: Image.asset('images/token2.png'),
  //               title: Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
  //               imageSize: width_ * 0.13,
  //             ),
  //             SizedBox(height: height_ * 0.02),
  //             buildRadioTile(
  //               value: 3,
  //               image: Image.asset('images/token3.png'),
  //               title: Text('3', style: TextStyle(fontWeight: FontWeight.bold)),
  //               imageSize: width_ * 0.14,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
// --------------------------------------------
  // Center TermsofUse(double height_, double width_) {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TextButton(
  //             onPressed: () {
  //               // Navigate to Terms of Use page
  //             },
  //             child: Text(
  //               'Terms of Use',
  //               style: TextStyle(
  //                 color: Color(0xFF7B7B7B),
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
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }