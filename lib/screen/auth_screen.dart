import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcfeff),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 5.0),
            SizedBox(
              height: 400,
              width: 350,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 200, 200, 200),
                        width: 3.0,
                      ),
                      color: Color.fromARGB(255, 214, 228, 239),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: (MediaQuery.of(context).size.width / 2) - 50,
                    child: GestureDetector(
                      onTap: () {
                        // Action to perform on button click
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                //  Handle the tap event.
              },
              child: Text(
                'or Sign Up with',
                style: TextStyle(
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
