import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Select Auth provider"),
          const AuthButton(iconData: Icons.email, tittle: "Email/Password"),
        ],
      )),
    );
  }
}
