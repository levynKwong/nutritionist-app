import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/api/purchase_api.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class BuyCoin extends StatefulWidget {
  const BuyCoin({Key? key}) : super(key: key);

  @override
  State<BuyCoin> createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await PurchaseApi.init();
  }

  Future<void> _buyCoins(String coinId) async {
    try {
      final purchaserInfo = await PurchaseApi.purchaseCoins(coinId);
      if (purchaserInfo != null) {
        // Handle the purchased package or update the UI accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchase successful.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchase failed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Purchase failed: ${error.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget buttons(double height_, double width_) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: width_ * 0.15),
          ElevatedButton(
            onPressed: () {
              _buyCoins('coin_2');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF575ecb),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Buy'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Your widget build code here
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Coin'),
      ),
      body: Center(
        child: buttons(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
      ),
    );
  }
}

class PurchaseApi {
  static const _apiKey = 'goog_JOqwYSmDCvNhYRFmMfOVybysoDu';

  static Future<void> init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);
  }

  static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.all.values.where((offer) => ids.contains(offer.identifier)).toList();
    } on PlatformException catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Offering>> fetchOffers({bool all = true}) async {
    try {
      final offerings = await Purchases.getOfferings();
      if (all) {
        final current = offerings.current;
        return current == null ? [] : [current];
      } else {
        return offerings.all.values.toList();
      }
    } on PlatformException catch (e) {
      print(e);
      return [];
    }
  }

  static Future purchaseCoins(String coinId) async {
    try {
      print('coinId: $coinId');
      final offerings = await fetchOffersByIds([coinId]);
      if (offerings.isNotEmpty) {
        final offering = offerings.first;
        final purchasePackage = offering.availablePackages.first;
        final purchaserInfo = await Purchases.purchasePackage(purchasePackage);
        return purchaserInfo;
      } else {
        print('No available offerings for coinId: $coinId');
        return null;
      }
    } on PlatformException catch (e) {
      print(e);
      return null;
    }
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