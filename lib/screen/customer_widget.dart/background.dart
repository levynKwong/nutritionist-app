import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class background1 extends StatelessWidget {
  const background1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 223, 255),
      ),
    );
  }
}
