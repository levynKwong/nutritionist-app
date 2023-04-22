import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/background_2.dart';
import 'package:meal_aware/screen/customer_widget.dart/sixDigitCode.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class confirmationNutritionist extends StatefulWidget {
  final String email,
      fullname,
      username,
      age,
      phonenumber,
      userType,
      address,
      specialization,
      customSpecialization,
      workExperience,
      gender;
  const confirmationNutritionist(
      {Key? key,
      required this.email,
      required this.fullname,
      required this.username,
      required this.age,
      required this.phonenumber,
      required this.userType,
      required this.address,
      required this.specialization,
      required this.customSpecialization,
      required this.workExperience,
      required this.gender})
      : super(key: key);

  @override
  State<confirmationNutritionist> createState() =>
      _confirmationNutritionistState(
          email,
          fullname,
          username,
          age,
          phonenumber,
          userType,
          address,
          specialization,
          customSpecialization,
          workExperience,
          gender);
}

class _confirmationNutritionistState extends State<confirmationNutritionist> {
  final _formKey = GlobalKey<FormState>();
  final String email,
      fullname,
      username,
      age,
      phonenumber,
      userType,
      address,
      specialization,
      customSpecialization,
      workExperience,
      gender;
  _confirmationNutritionistState(
      this.email,
      this.fullname,
      this.username,
      this.age,
      this.phonenumber,
      this.userType,
      this.address,
      this.specialization,
      this.customSpecialization,
      this.workExperience,
      this.gender);
  // String? _selectedSpecialization;
  // bool _showCustomSpecializationField = false;
  // String? _customSpecialization;
  // String? experience;
  // String? gender;
  // late String _filePath;
  // final addressController = TextEditingController();
  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    _textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _filePath = ''; // initialize _filePath with an empty string
  // }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    bool validateCode(String enteredCode, List<String> expectedCodes) {
      for (String expectedCode in expectedCodes) {
        if (enteredCode == expectedCode) {
          return true;
        }
      }
      return false;
    }

    List<String> expectedCodes = [
      "123456",
      "832547",
      "789012",
      "345678",
      "901234",
      "567890",
      "234567",
      "890123",
      "456789",
      "123456",
      "678901"
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            background2(),
            Column(
              children: [
                Container(),
                SizedBox(height: height_ * 0.08),
                Text(
                  'MeA',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: width_ * 0.20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height_ * 0.01),
                Text(
                  'MealAware Company Ltd',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height_ * 0.01),
                SingleChildScrollView(
                  child: SizedBox(
                    height: height_ * 0.65,
                    width: width_ * 0.93,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 136, 136, 136),
                              width: 3.0,
                            ),
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
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: height_ * 0.02),
                                  Text1(
                                    text: 'Confirmation',
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  Text3(
                                      text:
                                          'After you have mailed us your Professional Qualification Certificate.\n\ \n\Your information will be checked and verified by our team. '),
                                  SizedBox(height: height_ * 0.015),
                                  Text3(
                                    text:
                                        'A 6-digit code will be sent to your email. ',
                                  ),
                                  SizedBox(height: height_ * 0.015),
                                  Text3(
                                    text:
                                        'It will take up to 3 working days for response. ',
                                  ),
                                  SizedBox(height: height_ * 0.03),
                                  Text7(
                                    text: 'Enter your 6-digit code below: ',
                                  ),
                                  SizedBox(height: height_ * 0.03),
                                  confirmationCode(width_, height_),
                                  SizedBox(height: height_ * 0.04),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  // Get the entered code from the text fields
                                  String enteredCode = _textControllers
                                      .map((controller) => controller.text)
                                      .join("");

                                  if (validateCode(
                                      enteredCode, expectedCodes)) {
                                    saveNutritionist(
                                        fullname,
                                        username,
                                        email,
                                        age,
                                        phonenumber,
                                        userType,
                                        address,
                                        specialization,
                                        customSpecialization,
                                        workExperience,
                                        gender);
                                    // Navigate to the home screen if the entered code is valid
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                    );
                                  } else {
                                    // Show an error message if the entered code is invalid
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Invalid code. Please try again.'),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  height:
                                      MediaQuery.of(context).size.width * 0.12,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmationCode(double width_, double height_) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          SizedBox(
            width: width_ * 0.12,
            height: height_ * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width_ * 0.009),
              child: TextField(
                controller: _textControllers[i],
                maxLength: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: height_ * 0.025),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
      ],
    );
  }
}
