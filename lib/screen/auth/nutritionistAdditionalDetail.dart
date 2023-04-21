import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background_2.dart';

class NutritionistAdditionalDetail extends StatefulWidget {
  const NutritionistAdditionalDetail({Key? key}) : super(key: key);

  @override
  State<NutritionistAdditionalDetail> createState() =>
      _NutritionistAdditionalDetailState();
}

class _NutritionistAdditionalDetailState
    extends State<NutritionistAdditionalDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Stack(
          children: [
            background2(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(),
                  SizedBox(height: height_ * 0.02),
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
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: height_ * 0.7,
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
                            child: Column(
                              children: [
                                // Add your form fields here
                              ],
                            ),
                          ),
                        ],
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
