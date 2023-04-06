import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Set scaffold's background color to transparent
      body: Container(
        // Wrap the body in a container to add a gradient background
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 76, 146, 215),
              Color.fromARGB(255, 204, 223, 241),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -130,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(255, 83, 22, 42),
                      Color.fromARGB(255, 163, 180, 218),
                    ],
                    radius: 1,
                    center: Alignment(1, -1),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 153, 62, 100),
                    ],
                    radius: 1,
                    center: Alignment(-1, 1),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top + kToolbarHeight,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Welcome,',
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 216, 216, 216), // The color of the text
                            fontSize: 40.0, // The size of the text
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'MeA',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'MealAware Company Ltd',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 55.0),
                  SizedBox(
                    height: 500,
                    width: 370,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 162, 162, 162),
                              width: 3.0,
                            ),
                            color: Color.fromARGB(183, 214, 228, 239),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                  SizedBox(width: 40.0),
                                  Icon(
                                    Icons.female,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                  SizedBox(width: 40.0),
                                  Icon(
                                    Icons.transgender,
                                    color: Colors.grey,
                                    size: 55.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: (MediaQuery.of(context).size.width / 2) - 45,
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
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () {
                      //  Handle the tap event.
                    },
                    child: Text(
                      'or Sign Up with',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 25, 25),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
