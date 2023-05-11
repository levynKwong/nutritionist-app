import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/registration/patientConfimation/patientAdditionalDetail.dart';

class Terms_and_condition extends StatefulWidget {
  const Terms_and_condition({super.key});

  @override
  State<Terms_and_condition> createState() => _Terms_and_conditionState();
}

class _Terms_and_conditionState extends State<Terms_and_condition> {
  bool _isChecked = false;

  void updateCheckbox(bool? newValue) {
    setState(() {
      _isChecked = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Set scaffold's background color to transparent
      body:
          // Wrap the body in a container to add a gradient background

          SingleChildScrollView(
        child: Column(
          children: [
            Container(),
            SizedBox(height: height_ * 0.04),
            Text(
              'MeA',
              style: TextStyle(
                color: Color.fromARGB(255, 99, 144, 228),
                fontSize: width_ * 0.20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height_ * 0.0),
            Text(
              'MealAware Company Ltd',
              style: TextStyle(
                color: Color.fromARGB(255, 128, 164, 231),
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0.0),
            SizedBox(
              height: height_ * 0.75,
              width: width_ * 0.95,
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
                      color: Color.fromARGB(250, 214, 228, 239),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 0.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'TERMS AND CONDITIONS\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Welcome to our Nutritionist App! This app has been designed to provide you with useful nutritional advice and guidance, but before you use it, please take a few minutes to read our terms and conditions carefully. By using our app, you are agreeing to be bound by these terms and conditions, so if you don\'t agree with them, please don\'t use our app.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'DEFINITIONS\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'In these terms and conditions, the following definitions apply:\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text:
                                          'In these terms and conditions, the following definitions apply:\"App\" means the Nutritionist App."User" means any person who uses the App."Content" means all information, text, graphics, images, videos, and other material that is provided through the App."Nutritionist" means any person who provides nutritional advice through the App.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'USE OF THE APP\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The App is intended for informational purposes only and should not be used as a substitute for professional medical advice, diagnosis, or treatment.\n\nBy using our app you represent and warrant that (a) you are 18 years of age or older and you agree to be bound by this Agreement; (b) if you are under 18 years of age, you have obtained verifiable consent from a parent or legal guardian; and (c) your use of the App does not violate any applicable law or regulation. Your access to the App may be terminated without warning if the Operator believes, in its sole discretion, that you are under the age of 18 years and have not obtained verifiable consent from a parent or legal guardian. If you are a parent or legal guardian and you provide your consent to your child’s use of the App, you agree to be bound by this Agreement in respect to your child’s use of the App.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Nutritionist App may require you to create an account to use certain features. You must provide accurate and complete information when creating your account, and you are responsible for maintaining the security of your account.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'CONTENT\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'All content provided through the App is provided for informational purposes only. The Nutritionist App does not guarantee the accuracy, completeness, or usefulness of any content provided through the App, and the Nutritionist App is not responsible for any errors or omissions in the content.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'NUTRITIONIST SERVICES\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Nutritionist App provides a platform for users to connect with Nutritionists who can provide nutritional advice. The Nutritionists are not employees or agents of the Nutritionist App, and the Nutritionist App does not endorse any Nutritionist or their advice.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text:
                                          'Any agreement for nutritional advice is solely between the User and the Nutritionist. The Nutritionist App is not a party to any such agreement, and the Nutritionist App has no responsibility or liability for any advice or services provided by the Nutritionist.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'FEES\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Nutritionist App may charge fees for certain features or services, such as access to premium content or nutritional advice from a Nutritionist. If you choose to use any fee-based features or services, you agree to pay all applicable fees.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'INTELLECTUAL PROPERTY\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'All content provided through the App is owned by the Nutritionist App or its licensors and is protected by copyright, trademark, and other intellectual property laws. You may not copy, modify, distribute, or use any content provided through the App without the Nutritionist App\'s prior written consent.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'LIMITATION OF LIABILITY\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Nutritionist App is not liable for any damages or injuries arising from the use of the App or any content or services provided through the App. The Nutritionist App is not liable for any direct, indirect, incidental, consequential, or punitive damages arising from the use of the App.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'INDEMNIFICATION\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'You agree to indemnify and hold harmless the Nutritionist App, its officers, directors, employees, and agents from any claims, damages, or expenses arising from your use of the App or any content or services provided through the App.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text: 'GOVERNING LAW\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'These terms and conditions are governed by the laws of the state in which the Nutritionist App is headquartered.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text:
                                          'MODIFICATION OF TERMS AND CONDITIONS\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Nutritionist App may modify these terms and conditions at any time, and any such modification will be effective immediately upon posting on the App. Your continued use of the App after any modification constitutes your acceptance of the modified terms.\n\n',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                updateCheckbox(value);
                              },
                            ),
                            Text('Agree terms and conditions'),
                          ],
                        ),
                        const SizedBox(height: 35.0),
                      ],
                    ),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            if (_isChecked == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PatientAdditionalDetail(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.width * 0.12,
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
