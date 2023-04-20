import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/BookAppointment.dart';
import 'package:meal_aware/screen/home/Doctor_forum/ChatDoctor/ChatDoctor.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
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
        ],
      ),
    );
  }

  topTitle(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(top: height_ * 0.09754, left: width_ * 0.054),
      child: Row(
        children: [
          Icon(
            Icons.message,
            size: width_ * 0.08,
          ),
          SizedBox(width: 15),
          Text(
            "Message",
            style:
                TextStyle(fontSize: width_ * 0.07, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
