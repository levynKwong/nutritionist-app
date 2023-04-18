import 'package:flutter/material.dart';

class tokenCounter extends StatefulWidget {
  const tokenCounter({Key? key}) : super(key: key);

  @override
  State<tokenCounter> createState() => _tokenCounterState();
}

class _tokenCounterState extends State<tokenCounter> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
