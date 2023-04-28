import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/BookAppointment.dart';
import 'package:meal_aware/screen/home/Doctor_forum/ChatDoctor/ChatDoctor.dart';

import 'RandomChat.dart/randomChat.dart';

class DoctorForum extends StatelessWidget {
  const DoctorForum({Key? key}) : super(key: key);

  static const double _borderRadius = 23;
  static const double _textFactor = 1.4;
  static const double _iconSize = 0.1;
  static const double _boxWidth = 0.9;
  static const double _boxHeight = 0.1;
  static const dynamic _textColour = Colors.black;
  static const dynamic _iconColour = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          background(),
          _buildTitleBar(width_, height_),
          _buildImage(width_, height_),
          Positioned(
            left: 0,
            right: 0,
            bottom: height_ * 0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAppointmentButton(width_, height_, context),
                SizedBox(height: height_ * 0.02),
                _buildElevatedButton('Chat With Doctor', Icons.chat_rounded,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDoctorReg(),
                    ),
                  );
                }, width_, height_),
                SizedBox(height: height_ * 0.02),
                _buildElevatedButton('Chat With Friends', Icons.chat, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => randomChat(),
                    ),
                  );
                }, width_, height_),
                SizedBox(height: height_ * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.085, left: width_ * 0.00, right: width_ * 0.3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: SizedBox(
          height: 55,
          child: Container(
            padding: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   color: Color.fromARGB(255, 226, 226, 226),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_2_outlined,
                  size: width_ * 0.08,
                ),
                SizedBox(width: 15),
                Text(
                  "Doctor's Forum",
                  style: TextStyle(
                      fontSize: width_ * 0.07, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.18, left: width_ * 0.1, right: width_ * 0.1),
      width: width_ * 0.9,
      height: height_ * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width_ * 0.0),
        image: DecorationImage(
          image: AssetImage('images/heart2.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildElevatedButton(String text, IconData icon, Function() onPressed,
      double width_, double height_) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        width: _boxWidth * width_,
        height: _boxHeight * height_,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: _iconSize * width_,
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

  Widget _buildAppointmentButton(double width_, double height_, context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        width: _boxWidth * width_,
        height: _boxHeight * height_,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookAppointmentService(),
              ),
            );
          },
          icon: Icon(
            Icons.calendar_month_outlined,
            size: _iconSize * width_,
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
                  fontSize: width_ * 0.045,
                  fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                  text: 'Available 9:00 to 11:00 a.m',
                  style: TextStyle(
                      color: _textColour,
                      fontSize: width_ * 0.035,
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
