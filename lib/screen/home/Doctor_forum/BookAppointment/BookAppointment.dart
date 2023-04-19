import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/NutritionistBookApp.dart';

class BookAppointmentService extends StatefulWidget {
  const BookAppointmentService({super.key});

  @override
  State<BookAppointmentService> createState() => _BookAppointmentServiceState();
}

class _BookAppointmentServiceState extends State<BookAppointmentService> {
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
          searchBar(width_, height_),
          NutritionistService(width_, height_),
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
          Text5(text: 'Select a service'),
        ],
      ),
    );
  }

  searchBar(width_, height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.16, left: width_ * 0.05, right: width_ * 0.05),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          hintText: 'Search here for category',
          prefixIcon: Icon(Icons.search, size: 30, color: Colors.black),
        ),
      ),
    );
  }

  NutritionistService(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.31, left: width_ * 0.1, right: width_ * 0.5),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NutritionistBookAppointment(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: height_ * 0.06, horizontal: width_ * 0.06),
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
        margin: EdgeInsets.only(top: height_ * 0.88),
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
            // SizedBox(
            //     width: width_ * 0.15), // add some spacing between the buttons
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => NutritionistBookAppointment(),
            //       ),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(width_ * 0.3, 50),
            //     primary: Color(0xFF575ecb), // set background color
            //     onPrimary: Colors.white, // set text color
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //   ),
            //   child: Text('         Next         '),
            // ),
          ],
        ));
  }
}
