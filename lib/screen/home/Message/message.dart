import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/BookAppointment.dart';
import 'package:meal_aware/screen/home/Doctor_forum/ChatDoctor/ChatDoctor.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

import '../Doctor_forum/RandomChat.dart/randomChat.dart';

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
          searchBar(width_, height_),
        ],
      ),
    );
  }

  searchBar(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.19, left: width_ * 0.05, right: width_ * 0.02),
      height: height_ * 0.042,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Color.fromARGB(255, 1, 1, 1)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search, size: 30, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: height_ * 0.01),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline,
                size: 30, color: Color.fromARGB(255, 61, 67, 163)),
            onPressed: () {
              popUpButton();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> popUpButton() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Select an option :"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF575ecb),
                  ),
                ),
                child: Text("Add a Doctor"),
                onPressed: () {
                  // Handle Option 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDoctorReg(),
                    ),
                  ); // Close the dialog
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF575ecb),
                  ),
                ),
                child: Text("Add a Friend"),
                onPressed: () {
                  // Handle Option 2
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => randomChat(),
                    ),
                  ); // C// Close the dialog
                },
              ),
            ],
          ),
        );
      },
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
