import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';

class paymentAppointment extends StatefulWidget {
  const paymentAppointment({super.key});

  @override
  State<paymentAppointment> createState() => _paymentAppointmentState();
}

class _paymentAppointmentState extends State<paymentAppointment> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          background(),
          topTitle(width_, height_),
          topSubTitle(width_, height_),
          content(width_, height_),
          buttons(height_, width_)
        ],
      ),
    );
  }

  topTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.82, left: width_ * 0.05),
      child: Row(
        children: [
          Text6(text: 'Book Appointment'),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: NotificationWidget(),
            ),
          ),
        ],
      ),
    );
  }

  topSubTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(bottom: height_ * 0.74, left: width_ * 0.05),
      child: Row(
        children: [
          Text5(text: 'payment screen'),
        ],
      ),
    );
  }

  NutritionistService(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => (selectionDate()),
              //   ),
              // );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: height_ * 0.07, horizontal: width_ * 0.07),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/nutritionist.png',
                    width: width_ * 0.2,
                    height: height_ * 0.06,
                  ),
                  SizedBox(height: height_ * 0.01),
                  Text7(text: 'Nutritionist'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buttons(double height_, double width_) {
    return Container(
        margin: EdgeInsets.only(top: height_ * 0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width_ * 0.3, 50),
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('        Back       '),
            ),
            SizedBox(width: width_ * 0.05),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width_ * 0.3, 50),
                primary: Color(0xFF575ecb), // set background color
                onPrimary: Colors.white, // set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/token_.png', // replace this with the path to your image asset
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Text('1 coin'),
                ],
              ),
            ),
          ],
        ));
  }

  Widget content(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.2),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.05),
            child: Column(
              children: [
                Text(
                  'Read before pressing on the coin',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 175, 67, 67),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height_ * 0.08),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text2(
                      text:
                          'With 1 Coin you are only paying half of the price, this makes sure that your appointment has been reserved'),
                ),
                SizedBox(height: height_ * 0.05),
                Container(
                  margin: EdgeInsets.only(
                      left: width_ * 0.05, right: width_ * 0.05),
                  child: Text2(
                      text:
                          'If you want to change the date of your appointment in the future, contact your nutritionist'),
                ),
                SizedBox(height: height_ * 0.04),
                NutritionistService(width_, height_),
                SizedBox(height: height_ * 0.035),
                TermsofUse(height_, width_),
              ],
            ),
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
}
