import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/NutritionistChat.dart';

class ChatDoctorReg extends StatefulWidget {
  const ChatDoctorReg({super.key});

  @override
  State<ChatDoctorReg> createState() => _ChatDoctorRegState();
}

class _ChatDoctorRegState extends State<ChatDoctorReg> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarTop(titleText: 'Chat with your Doctor'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height_ * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: width_ * 0.05),
                  Text5(text: 'Select a service'),
                ],
              ),
              NutritionistService(width_, height_, context),
              SizedBox(height: height_ * 0.42),
              buttons(height_, width_, context)
            ],
          ),
        ),
      ),
    );
  }
}

topTitle(double width_, double height_) {
  return Container(
    margin: EdgeInsets.only(bottom: height_ * 0.82, left: width_ * 0.05),
    child: Row(
      children: [
        Text6(text: 'Chat with your Doctor'),
        // Expanded(
        //   child: Container(
        //     alignment: Alignment.centerRight,
        //     child: NotificationWidget(),
        //   ),
        // ),
      ],
    ),
  );
}

NutritionistService(double width_, double height_, context) {
  return Container(
    margin: EdgeInsets.only(
        top: height_ * 0.02, left: width_ * 0.05, right: width_ * 0.55),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NutritionistChat(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: height_ * 0.06, horizontal: width_ * 0.07),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: getColor(context),
            ),
            child: Column(
              children: [
                Image.asset(
                  'images/nutritionist.png',
                  width: width_ * 0.2,
                  height: height_ * 0.06,
                  color:Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: height_ * 0.01),
                Text(
                  'Nutritionist',
                  style: TextStyle(fontSize: width_ * 0.045),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container buttons(double height_, double width_, context) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: getColor(context),
          minimumSize: Size(width_ * 0.3, 50), // set text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('        Back       '),
      ),
    ],
  ));
}
