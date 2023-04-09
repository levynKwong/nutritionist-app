import 'package:flutter/material.dart';

class DoctorForum extends StatelessWidget {
  const DoctorForum({Key? key}) : super(key: key);

  static const double _borderRadius = 23;
  static const double _textFactor = 1.3;
  static const double _iconSize = 30;
  static const double _boxWidth = 325;
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
          _buildTitleBar(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAppointmentButton(),
                SizedBox(height: 30),
                _buildElevatedButton(
                    'Chat With Doctor', Icons.chat_rounded, () {}),
                SizedBox(height: 30),
                _buildElevatedButton('Chat With Friends', Icons.chat, () {}),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: SizedBox(
          height: 55,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 226, 226, 226),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_2_outlined,
                  size: 30,
                ),
                SizedBox(width: 15),
                Text(
                  "Doctor's Forum",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(
      String text, IconData icon, Function() onPressed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        width: _boxWidth,
        height: _boxHeight,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: _iconSize,
            color: _iconColour[600],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 173, 184, 252)),
          ),
          label: Text(
            text,
            textScaleFactor: _textFactor,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textColour,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentButton() {
    return ClipRRect(
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
    );
  }
}
