import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/introduction/chatNutritionistHelp.dart';
import 'package:meal_aware/screen/auth/introduction/introduction_patient.dart';
import 'package:meal_aware/screen/auth/introduction/lockChat.dart';
import 'package:meal_aware/screen/auth/introduction/nutritionistAppoinment.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/termsAndContitionHelpPage.dart';

class HelpPagePatient extends StatelessWidget {
  const HelpPagePatient({super.key});

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBarTopBack(
          titleText: 'Help Page',
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => introductionPatient(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Introduction to MealAware',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => introductionPatient(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How to get coin?',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => chatNutritionistHelp(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How to start chat with a nutritionist?',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => lockChat(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How to continue chat with your nutritionist after lock?',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nutritionistAppoinment(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How to book an appointment with your nutritionist?',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionsInHelpPage(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
