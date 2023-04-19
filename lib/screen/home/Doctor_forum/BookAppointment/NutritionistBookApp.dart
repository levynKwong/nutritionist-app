import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_widget.dart';

class NutritionistBookAppointment extends StatefulWidget {
  const NutritionistBookAppointment({super.key});

  @override
  State<NutritionistBookAppointment> createState() =>
      _NutritionistBookAppointmentState();
}

class _NutritionistBookAppointmentState
    extends State<NutritionistBookAppointment> {
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
          Box(width_, height_),
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
          Text6(text: 'Nutritionist'),
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
          Text5(text: 'Here are our valued Nutritionist'),
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('Button pressed');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: height_ * 0.032, horizontal: width_ * 0.07),
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

  Box(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
        top: height_ * 0.23,
        left: width_ * 0.001,
        right: width_ * 0.001,
      ),
      child: Form(
        // key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width * 1.4,
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(42, 214, 228, 239),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NutritionistService(width_, height_),
                    SizedBox(height: height_ * 0.02),
                    NutritionistService(width_, height_),
                    SizedBox(height: height_ * 0.02),
                    NutritionistService(width_, height_),
                    SizedBox(height: height_ * 0.02),
                    NutritionistService(width_, height_),
                    SizedBox(height: height_ * 0.02),
                    NutritionistService(width_, height_),
                  ],
                ),
              ),
            ),
          ),
        ),
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
          ],
        ));
  }
}
