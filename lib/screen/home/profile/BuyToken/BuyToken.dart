import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

import 'package:meal_aware/screen/customer_widget.dart/tokenCounter.dart';

class BuyToken extends StatefulWidget {
  const BuyToken({super.key});

  @override
  State<BuyToken> createState() => _BuyTokenState();
}

class _BuyTokenState extends State<BuyToken> {
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

          selectionButton(height_, width_),
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
                // add onPressed function
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('        Pay       '),
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
              child: Text('Use Coupon'),
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

  Widget selectionButton(double height_, double width_) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: height_ * 0.3),
        child: Container(
          width: width_ * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildRadioTile(
                value: 1,
                image: Image.asset('images/token_.png'),
                title: Text('1'),
              ),
              SizedBox(height: height_ * 0.02),
              buildRadioTile(
                value: 2,
                image: Image.asset('images/token_.png'),
                title: Text('2'),
              ),
              SizedBox(height: height_ * 0.02),
              buildRadioTile(
                value: 3,
                image: Image.asset('images/token_.png'),
                title: Text('3'),
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
        activeColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: image,
            ),
            SizedBox(width: 19),
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
            Text3(text: 'Buy Token')
          ],
        ),
        SizedBox(
          width: width_ * 0.09,
        ),
      ],
    );
  }
}
