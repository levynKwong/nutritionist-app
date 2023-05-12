import 'package:flutter/material.dart';

class MyCenteredText extends StatelessWidget {
  final String text;

  const MyCenteredText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
