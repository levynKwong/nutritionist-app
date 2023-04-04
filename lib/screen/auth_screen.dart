import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcfeff),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Welcome,',
                  style: TextStyle(
                    color: Colors.black, // The color of the text
                    fontSize: 40.0, // The size of the text
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 0.0),
          Image.asset(
            'images/workout.jpg',
            height: 300.0,
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Select Auth provider",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    AuthButton(
                      iconData: Icons.email,
                      tittle: "Email/Password",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
