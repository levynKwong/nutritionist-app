import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/BookAppointment.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/ChatDoctor.dart';

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
      appBar: appBarTop(titleText: 'Doctor\'s Forum'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height_ * 0.07),
          Container(
            width: double.infinity,
            height: height_ * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/doctor_forum.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: height_ * 0.05),
          Container(
            padding: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.05),
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
            // Check if the user is from Mauritius
            FirebaseFirestore.instance
                .collection('Patient')
                .doc(userId)
                .get()
                .then((doc) {
              if (doc.exists && doc['Country'] == "1") {
                // Navigate to the BookAppointmentService screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookAppointmentService(),
                  ),
                );
              } else {
                // Show a message indicating that the feature is only available to Mauritius
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('This feature is only available to Mauritius'),
                ));
              }
            });
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
