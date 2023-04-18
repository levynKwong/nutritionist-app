import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';

class BuyToken extends StatefulWidget {
  const BuyToken({super.key});

  @override
  State<BuyToken> createState() => _BuyTokenState();
}

class _BuyTokenState extends State<BuyToken> {
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
              children: [topBar(width_, height_, context)],
            ),
          ),
          YourToken(width_, height_),
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
          )
        ],
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

  Widget YourToken(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height_ * 0.5,
        left: width_ * 0.1,
        right: width_ * 0.1,
      ),
      child: Center(
        child: SizedBox(
          height: height_ * 0.15,
          width: width_ * 0.6,
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Color.fromARGB(255, 177, 177, 177)),
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFa9c3f4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Your Token:",
                    style: TextStyle(
                      fontSize: width_ * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/token_.png',
                          width: width_ * 0.08,
                          height: height_ * 0.08,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: width_ * 0.1),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: width_ * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
