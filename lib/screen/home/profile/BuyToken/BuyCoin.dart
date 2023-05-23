import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/GetCoin.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class BuyCoin extends StatefulWidget {
  const BuyCoin({super.key});

  @override
  State<BuyCoin> createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  int selectedRadio = 0;
  // late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    // _googlePayConfigFuture = PaymentConfiguration.fromAsset('google_pay.json');
    // // checkPaymentAvailability();
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
      body: Stack(
        children: [
          background(),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  topBar(width_, height_, context),
                  CoinCounter(),
                  SizedBox(
                    height: height_ * 0.06,
                  ),
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
                  SizedBox(
                    height: height_ * 0.06,
                  ),
                  selectionButton(height_, width_),
                  SizedBox(
                    height: height_ * 0.02,
                  ),
                  TermsofUse(height_, width_),
                  SizedBox(
                    height: height_ * 0.02,
                  ),
                  buttons(height_, width_),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons(double height_, double width_) {
    // final _paymentItems = [
    //   PaymentItem(
    //     label: 'Total',
    //     amount: '99.99',
    //     status: PaymentItemStatus.final_price,
    //   )
    // ];

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    // final Future<PaymentConfiguration> _googlePayConfigFuture =
    //     PaymentConfiguration.fromAsset(
    //         'default_payment_profile_google_pay.json');
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FutureBuilder<PaymentConfiguration>(
          //   future: _googlePayConfigFuture,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return GooglePayButton(
          //         paymentConfiguration: snapshot.data!,
          //         paymentItems: _paymentItems,
          //         type: GooglePayButtonType.pay,
          //         margin: const EdgeInsets.only(top: 15.0),
          //         onPaymentResult: onGooglePayResult,
          //         loadingIndicator: const Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     } else if (snapshot.hasError) {
          //       print("Error: ${snapshot.error}");
          //       return Text(
          //           'Error loading payment configuration: ${snapshot.error}');
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   },
          // ),
          SizedBox(width: width_ * 0.15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetCoin(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF575ecb),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Use Coupon'),
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

  Widget selectionButton(double height_, double width_) {
    return Center(
      child: Container(
        child: Container(
          width: width_ * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildRadioTile(
                value: 1,
                image: Image.asset('images/token1.png'),
                title: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                imageSize: width_ * 0.11, // <-- Set the size of the image
              ),
              SizedBox(height: height_ * 0.02),
              buildRadioTile(
                value: 2,
                image: Image.asset('images/token2.png'),
                title: Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
                imageSize: width_ * 0.13, // <-- Set the size of the image
              ),
              SizedBox(height: height_ * 0.02),
              buildRadioTile(
                value: 3,
                image: Image.asset('images/token3.png'),
                title: Text('3', style: TextStyle(fontWeight: FontWeight.bold)),
                imageSize: width_ * 0.14, // <-- Set the size of the image
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioTile({
    required int value,
    required Image image,
    required Widget title,
    required double imageSize, // <-- Add a parameter for image size
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFa0b1f9),
      ),
      height: 60,
      child: RadioListTile(
        value: value,
        groupValue: selectedRadio,
        onChanged: (val) {
          print('number $val');
          setSelectedRadio(val!);
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Color(0xFF575dcb),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: image,
            ),
            SizedBox(width: 26),
            Flexible(child: title),
          ],
        ),
      ),
    );
  }

  Widget topBar(double width_, double height_, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())),
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
            Text3(text: 'Buy Coin')
          ],
        ),
        SizedBox(
          width: width_ * 0.09,
        ),
      ],
    );
  }
}
