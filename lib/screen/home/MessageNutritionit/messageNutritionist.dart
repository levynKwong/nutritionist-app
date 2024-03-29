import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/ChatDoctor.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/ChatListScreenNutritionist.dart';

import '../Doctor_forum/RandomChat.dart/randomChat.dart';

class messageNutritionist extends StatefulWidget {
  const messageNutritionist({super.key});

  @override
  State<messageNutritionist> createState() => _messageNutritionistState();
}

class _messageNutritionistState extends State<messageNutritionist> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: getColor(context),
        title: Text('Message Nutritionist'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              popUpButton();
            },
          ),
          // NotificationWidget(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('images/pattern_food.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Stack(
          children: [
            ChatListScreenNutritionist(),
          ],
        ),
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
                    getColor(context),
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
                    getColor(context),
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
}
