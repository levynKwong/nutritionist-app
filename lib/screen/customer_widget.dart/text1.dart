import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Text1 extends StatelessWidget {
  final String text;
  const Text1({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
