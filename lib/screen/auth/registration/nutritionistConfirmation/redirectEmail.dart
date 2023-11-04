import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse('mailto:'));
      },
      child: Text.rich(
        TextSpan(
          text:
              'Send us your Professional Qualification Certificate on our email:\n\Click on the mail:\n',
          style: TextStyle(
            fontSize: width_ * 0.04, // Change the font size to 18
          ),
          children: [
            TextSpan(
              text: 'mealawareness@gmail.com',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: width_ * 0.05, // Change the font size to 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}
