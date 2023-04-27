import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          appBar(width_),
          SizedBox(
            height: height_ * 0.0,
          ),
          info(width_, height_),
          SizedBox(
            height: height_ * 0.0,
          ),
          client(width_, height_),
        ],
      ),
    );
  }

  Widget client(double width_, double height_) {
    return SizedBox(
      height: height_ * 0.55,
      width: width_ * 1.3,
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }

  Widget info(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width_ * 0.04,
              ),
              Container(
                width: width_ * 0.44,
                height: height_ * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width_ * 0.03,
              ),
              Container(
                width: width_ * 0.44,
                height: height_ * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width_ * 0.04,
              ),
            ],
          ),
          SizedBox(
            height: height_ * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: width_ * 0.04,
              ),
              Container(
                width: width_ * 0.44,
                height: height_ * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width_ * 0.03,
              ),
              Container(
                width: width_ * 0.44,
                height: height_ * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width_ * 0.04,
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar(double width_) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.black,
          fontSize: width_ * 0.07,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
          onPressed: () {
            // Add your code here for calendar icon action
          },
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            // Add your code here for notification icon action
          },
        ),
      ],
    );
  }
}
