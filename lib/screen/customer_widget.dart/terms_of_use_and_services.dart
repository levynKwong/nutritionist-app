import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/termAndContidionDialog.dart';

class termNcondition extends StatelessWidget {
  const termNcondition({super.key});

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              
            },
            child: Text(
              'Terms of Use',
              style: TextStyle(
                color: Color(0xFF7B7B7B),
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text(
            ' | ',
            style: TextStyle(
              color: Color(0xFF7B7B7B),
            ),
          ),
          TextButton(
            onPressed: () {
              TermsAndConditionsDialog();
            },
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                color: Color(0xFF7B7B7B),
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
