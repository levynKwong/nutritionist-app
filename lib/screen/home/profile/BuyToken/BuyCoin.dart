import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/GetCoin.dart';

class BuyCoin extends StatefulWidget {
  const BuyCoin({Key? key}) : super(key: key);

  @override
  State<BuyCoin> createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static const String coinId1 = 'coin_1_mealaware_consumable';
  static const String coinId2 = 'coin_2_mealaware_consumable';
  static const String coinId3 = 'coin_3_mealaware_consumable';

  static const List<String> _kProductIds = <String>[
    coinId1,
    coinId2,
    coinId3,
  ];
  bool _isUpdatingCoinCount = false; // Add this flag
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
    return true;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    if (_isUpdatingCoinCount) {
      return; // Skip if coin count is already being updated
    }

    if (_purchases.contains(purchaseDetails)) {
      return; // Skip if the purchase has already been processed
    }
    setState(() {
      _isUpdatingCoinCount =
          true; // Set the flag to indicate the update process has started
    });

    if (purchaseDetails.status == PurchaseStatus.purchased) {
      if (purchaseDetails.productID == coinId1) {
        notifyPurchase(context);
        await _updateUserCoinCount(1);
      } else if (purchaseDetails.productID == coinId2) {
        notifyPurchase(context);
        await _updateUserCoinCount(2);
      } else if (purchaseDetails.productID == coinId3) {
        notifyPurchase(context);
        await _updateUserCoinCount(3);
      }
    }

    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });

    setState(() {
      _isUpdatingCoinCount =
          false; // Reset the flag after the update process is completed
    });
  }

  Future<void> _updateUserCoinCount(int coinsToAdd) async {
    setState(() {
      _isUpdatingCoinCount =
          true; // Set the flag to indicate the update process has started
    });

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      final userDoc = FirebaseFirestore.instance.collection('Patient').doc(uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userDoc);
        final currentCoins = userSnapshot.data()!['coin'] ?? 0;
        int newCoins = currentCoins + coinsToAdd;
        transaction.update(userDoc, {'coin': newCoins});
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Coins added successfully!')),
      );
      NotificationService.showNotification(
        title: 'Payment Successful',
        body: 'You have successfully purchased $coinsToAdd coins!',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );

      _purchases.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );

      notify(context);
    } finally {
      if (mounted) {
        setState(() {
          _isUpdatingCoinCount =
              false; // Reset the flag after the update process is completed
        });
      }
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
                      _inAppPurchase.buyConsumable(
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
                        Text('Buy 1 coin '),
                        SizedBox(width: width_ * 0.10),
                        Text("Rs 600")
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.015),
                  ElevatedButton(
                    onPressed: () {
                      _inAppPurchase.buyConsumable(
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
                        SizedBox(width: width_ * 0.09),
                        Text("Rs 1200")
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.015),
                  ElevatedButton(
                    onPressed: () {
                      _inAppPurchase.buyConsumable(
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
                        SizedBox(width: width_ * 0.09),
                        Text("Rs 1800")
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

  void notify(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Error'),
          content: Text(
            'Failed to complete the purchase. If you have made a purchase and have not received any coin, please contact us by sending us an email at mealawareness@gmail.com. Make sure to give us the email that you registered in the app and the email you used to make the payment which is your google play account.\n\n We are sorry for the inconvenience.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void notifyPurchase(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Important notice'),
          content: Text(
            'Your purchase is going through, please wait a few seconds. Make sure not to make another purchase and wait as this might create a conflict. The purchase will not be refunded if accidentally made multiple purchases.\n\nFor any questions, please contact us by sending us an email at mealawareness@gmail.com',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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
