import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background_2.dart';
import 'package:meal_aware/screen/customer_widget.dart/sixDigitCode.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:file_picker/file_picker.dart';

class confirmationNutritionist extends StatefulWidget {
  const confirmationNutritionist({Key? key}) : super(key: key);

  @override
  State<confirmationNutritionist> createState() =>
      _confirmationNutritionistState();
}

class _confirmationNutritionistState extends State<confirmationNutritionist> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedSpecialization;
  bool _showCustomSpecializationField = false;
  String? _customSpecialization;
  String? experience;
  String? gender;
  late String _filePath;
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filePath = ''; // initialize _filePath with an empty string
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

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
                    height: height_ * 0.66,
                    width: width_ * 0.9,
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
                                        'An Email has been sent to us for confirmation,\n\ Please wait for the an email',
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  Text3(
                                    text:
                                        'A 6-digit code will be sent to your email. ',
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  Text3(
                                    text:
                                        'It will take up to 3 working days for response. ',
                                  ),
                                  SizedBox(height: height_ * 0.07),
                                  Text7(
                                    text: 'Enter your 6-digit code below: ',
                                  ),
                                  SizedBox(height: height_ * 0.06),
                                  CouponCodeInput(),
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
                                onTap: () {},
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
}
