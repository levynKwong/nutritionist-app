import 'package:flutter/material.dart';

class DoctorForum extends StatelessWidget {
  const DoctorForum({Key? key}) : super(key: key);

  static const double _borderRadius = 23;
  static const double _textFactor = 1.3;
  static const double _iconSize = 30;
  static const double _boxWidth = 300;
  static const double _boxHeight = 75;
  static const dynamic _textColour = Colors.black;
  static const dynamic _iconColour = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Wrap the body in a container to add a gradient background
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 203, 222, 250),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: SizedBox(
                    width: _boxWidth,
                    height: _boxHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        size: _iconSize,
                        color: _iconColour[600],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 173, 184, 252)),
                      ),
                      label: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Book an Appointment\n',
                          style: TextStyle(
                              color: _textColour,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Available 9:00 to 11:00 a.m',
                              style: TextStyle(
                                  color: _textColour,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: SizedBox(
                    width: _boxWidth,
                    height: _boxHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chat_rounded,
                        size: _iconSize,
                        color: _iconColour[600],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 173, 184, 252)),
                      ),
                      label: Text(
                        'Chat With Doctor',
                        textScaleFactor: _textFactor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _textColour,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: SizedBox(
                    width: _boxWidth,
                    height: _boxHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chat,
                        size: _iconSize,
                        color: _iconColour[600],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 173, 184, 252)),
                      ),
                      label: Text(
                        'Chat With Friends',
                        textScaleFactor: _textFactor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _textColour,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
