import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'MealAware is an innovative application designed to assist youngsters in making informed dietary choices based on their specific health goals. Our mission is to empower individuals to lose weight, gain weight, or improve their overall health by providing them with personalized meal recommendations and access to professional nutritionists.\n\nWith MealAware, users can engage in interactive conversations with experienced nutritionists who can offer guidance, answer questions, and provide expert advice tailored to their unique needs. Our platform also allows users to conveniently book appointments with nutritionists for in-depth consultations, ensuring they receive personalized attention and support.\n\nIn addition to the nutritionist services, MealAware offers a supportive community feature that enables users to anonymously chat with other individuals who are on a similar health journey. This fosters a sense of belonging, support, and motivation, as users can share experiences, seek advice, and provide encouragement to one another.\n\nMealAware\'s goal is to provide young individuals with a comprehensive solution for achieving their health goals while promoting a positive and inclusive environment. By combining expert nutritionist guidance, personalized meal plans, and an anonymous chat community, we aim to empower and inspire youngsters to make healthier choices and lead happier, more fulfilling lives.\n\nIf you need to reach out to us, please email us at mealawareness@gmail.com\n\n 2023 MealAware. All Rights Reserved.\n\nCredits: Levyn KHS (developer)',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
