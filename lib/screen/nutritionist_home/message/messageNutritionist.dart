import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meal_aware/screen/ChatScreen/ChatListScreen.dart';

class messageClient extends StatefulWidget {
  const messageClient({super.key});

  @override
  State<messageClient> createState() => _messageClientState();
}

class _messageClientState extends State<messageClient> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          appBar(width_),
          SizedBox(
            height: height_ * 0.01,
          ),
          searchBar(width_, height_),
          ChatListScreen()
        ],
      ),
    );
  }

  AppBar appBar(double width_) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Message your client',
        style: TextStyle(
          color: Colors.black,
          fontSize: width_ * 0.07,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
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

  searchBar(double width_, double height_) {
    return Container(
      margin: EdgeInsets.only(left: width_ * 0.05, right: width_ * 0.02),
      height: height_ * 0.042,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Color.fromARGB(255, 1, 1, 1)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 107, 150, 231),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search,
                    size: width_ * 0.08, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: height_ * 0.01),
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.add_circle_outline,
          //       size: width_ * 0.08, color: Color.fromARGB(255, 61, 67, 163)),
          //   // onPressed: () {
          //   //   popUpButton();
          //   // },
          // ),
        ],
      ),
    );
  }
}
