import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final IconData iconData;
  final String tittle;
  const AuthButton({Key? key, required this.iconData, required this.tittle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          Text(tittle),
        ],
      ),
    );
  }
}
