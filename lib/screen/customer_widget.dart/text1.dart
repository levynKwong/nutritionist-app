import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class text1 extends StatelessWidget {
  const text1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Verifiy your email',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
