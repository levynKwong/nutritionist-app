import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/nutritionist_home/message/ChatListScreenClient.dart';

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: getColor(),
        title: Text('Message your client'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/pattern_food.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            ChatListScreenClient(),
          ],
        ),
      ),
    );
  }
}
