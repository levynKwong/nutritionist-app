import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/tokenCounter.dart';
import 'package:meal_aware/screen/customer_widget.dart/sixDigitCode.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/BuyToken.dart';

class GetToken extends StatefulWidget {
  const GetToken({super.key});

  @override
  State<GetToken> createState() => _GetTokenState();
}

class _GetTokenState extends State<GetToken> {
  int selectedRadio = 0;

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
          Container(
            margin: EdgeInsets.symmetric(vertical: height_ * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [topBar(width_, height_, context)], //correct
            ),
          ),
          tokenCounter(), //correct

          SizedBox(
            height: height_ * 0.0,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: height_ * 0.15,
              left: width_ * 0.1,
              right: width_ * 0.1,
            ),
            child: Text4(
              text:
                  'lorem ipsum delor ndjnajdkbad \n\ dajdbajdbaldjbad \n\ DDbjawdjbaDLJkbadj\n\ BADJKBAdjabwdjkawbd',
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height_ * 0.14,
              left: width_ * 0.1,
              right: width_ * 0.1,
            ),
            child: Text4(
              text: 'Enter Your Coupon Code:',
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height_ * 0.65,
              left: width_ * 0.1,
              right: width_ * 0.1,
            ),
            child: CouponCodeInput(),
          ),

          TermsofUse(height_, width_),
          buttons(height_, width_)
        ],
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        margin: EdgeInsets.only(top: height_ * 0.89),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyToken(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('    Back   '),
            ),
            SizedBox(
                width: width_ * 0.15), // add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // add onPressed function
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Confirm'),
            ),
          ],
        ));
  }

  Center TermsofUse(double height_, double width_) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            top: height_ * 0.65, left: width_ * 0.1, right: width_ * 0.1),
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
            Text3(text: 'Get Token')
          ],
        ),
        SizedBox(
          width: width_ * 0.09,
        ),
      ],
    );
  }
}
