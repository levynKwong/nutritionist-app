import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/auth_screen_register.dart';

class ParentAuth extends StatefulWidget {
  const ParentAuth({Key? key}) : super(key: key);

  @override
  State<ParentAuth> createState() => _ParentAuthState();
}

class _ParentAuthState extends State<ParentAuth> {
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
              Color(0xFF5e8eea),
              Color.fromARGB(255, 214, 225, 249),
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
                      Color.fromARGB(0, 81, 100, 153),
                      Color(0xFFe884d0),
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
                      Color(0xFF9553ac),
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
                  Container(),
                  const SizedBox(height: 45.0),
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
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 620,
                    width: 370,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Color.fromARGB(255, 136, 136, 136),
                            //   width: 3.0,
                            // ),
                            color: Color.fromARGB(183, 214, 228, 239),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 207, 207, 207)
                                    .withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Since you are under 18, you need to have a parent or guardian to register you.',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromARGB(255, 197, 51, 40),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Create an account to continue',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Patient',
                                      prefixIcon: Icon(Icons.account_circle),
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Patient',
                                        child: Text('Patient'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      // Do something with the new value
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText:
                                          'Enter your child\'s\ Full Name',
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText:
                                          'Enter your child\'s\ Username',
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      prefixIcon: Icon(Icons.person_pin),
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Male',
                                        child: Text('Male'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Female',
                                        child: Text('Female'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Non-Binary',
                                        child: Text('Non-Binary'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Email',
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Enter the age of your child',
                                      prefixIcon: Icon(Icons.date_range),
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: '1-5',
                                        child: Text('1-5'),
                                      ),
                                      DropdownMenuItem(
                                        value: '6-10',
                                        child: Text('6-10'),
                                      ),
                                      DropdownMenuItem(
                                        value: '11-15',
                                        child: Text('11-15'),
                                      ),
                                      DropdownMenuItem(
                                        value: '16-18',
                                        child: Text('16-18'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      // Do something with the new value
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText:
                                          'PhoneNumber of Parent/Guardian',
                                      prefixIcon: Icon(Icons.phone),
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
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    'By pressing "submit" you agree to our',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //  Handle the tap event.
                                    },
                                    child: Text(
                                      'Terms and Conditions',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 196, 20, 20),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (RegisterScreen()),
                        ),
                      );
                    },
                    child: Text(
                      'or back to register',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
