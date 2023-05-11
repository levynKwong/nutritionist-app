import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';

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

  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());

  Future<bool> validateCodeAndUpdateExpectedCodes(String enteredCode) async {
    final CollectionReference codesCollection =
        FirebaseFirestore.instance.collection('confirmationCode');

    try {
      // Get the document reference for the entered code
      final QuerySnapshot codesSnapshot =
          await codesCollection.where('code', isEqualTo: enteredCode).get();
      final DocumentReference? enteredCodeRef = codesSnapshot.docs.isNotEmpty
          ? codesSnapshot.docs.first.reference
          : null;

      if (enteredCodeRef != null) {
        // Delete the entered code document from the collection
        await enteredCodeRef.delete();
        print('Removed $enteredCode from expected codes');
        return true; // Code is valid and has been removed from expected codes
      } else {
        print(
            'Error: $enteredCode does not exist in expected codes collection');
        return false; // Code is invalid
      }
    } catch (e) {
      print('Error removing $enteredCode from expected codes: $e');
      return false; // Code is invalid due to error
    }
  }

  @override
  void dispose() {
    _textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: height_ * 0.05),
                Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text(
                          'MeA',
                          style: TextStyle(
                            color: Color.fromARGB(255, 99, 144, 228),
                            fontSize: width_ * 0.20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height_ * 0.01),
                        Text(
                          'MealAware Company Ltd',
                          style: TextStyle(
                            color: Color.fromARGB(255, 128, 164, 231),
                            fontSize: width_ * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height_ * 0.06),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Text(
                                        'Confirmation',
                                        style: TextStyle(
                                          fontSize: width_ * 0.08,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.02),
                                  Center(
                                    child: Text(
                                      'Confirm your account to continue',
                                      style: TextStyle(
                                        fontSize: width_ * 0.04,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width_ * 0.05),
                                      child: Text3(
                                          text:
                                              'After you have mailed us your Professional Qualification Certificate.\n\ \n\Your information will be checked and verified by our team. '),
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.015),
                                  Center(
                                    child: Text3(
                                      text:
                                          'A 6-digit code will be sent to your email. ',
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.015),
                                  Center(
                                    child: Text3(
                                      text:
                                          'It will take up to 3 working days for response. ',
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.03),
                                  Center(
                                    child: Text7(
                                      text: 'Enter your 6-digit code below: ',
                                    ),
                                  ),
                                  SizedBox(height: height_ * 0.03),
                                  Center(
                                      child: confirmationCode(width_, height_)),
                                  SizedBox(height: height_ * 0.04),
                                  // add additional widgets here if needed
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              width_ * 0.08, 0, width_ * 0.08, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              String enteredCode = _textControllers
                                  .map((controller) => controller.text)
                                  .join("");

                              if (await validateCodeAndUpdateExpectedCodes(
                                  enteredCode)) {
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
                                    builder: (context) => NutritionistHome(),
                                  ),
                                );
                              } else {
                                // Show an error message if the entered code is invalid
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Invalid code. Please try again.'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xFF6889c6), // sets the background color of the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: height_ * 0.06,
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: width_ * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
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
