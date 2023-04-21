import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/background_2.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:file_picker/file_picker.dart';

class NutritionistAdditionalDetail extends StatefulWidget {
  const NutritionistAdditionalDetail({Key? key}) : super(key: key);

  @override
  State<NutritionistAdditionalDetail> createState() =>
      _NutritionistAdditionalDetailState();
}

class _NutritionistAdditionalDetailState
    extends State<NutritionistAdditionalDetail> {
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
                                  Text3(
                                    text: 'Additional Details',
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  TextFormField(
                                    controller: addressController,
                                    decoration: InputDecoration(
                                      labelText: 'Address of work',
                                      prefixIcon: Icon(Icons.location_on),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your address of work';
                                      } else if (!RegExp(
                                              r"^[A-Za-z\s]+(?:[-\s][A-Za-z\s]+)*$")
                                          .hasMatch(value)) {
                                        return 'Please enter a valid address';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Specialization',
                                      prefixIcon: Icon(Icons.local_hospital),
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedSpecialization,
                                    items: [
                                      DropdownMenuItem(
                                        value: '1',
                                        child: Text('Sport Nutritionist'),
                                      ),
                                      DropdownMenuItem(
                                        value: '2',
                                        child: Text('Pediatric Nutritionist'),
                                      ),
                                      DropdownMenuItem(
                                        value: '3',
                                        child: Text('Clinical Nutritionist'),
                                      ),
                                      DropdownMenuItem(
                                        value: '4',
                                        child: Text('General Nutritionist'),
                                      ),
                                      DropdownMenuItem(
                                        value: '5',
                                        child: Text('Other'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedSpecialization = newValue;
                                        _showCustomSpecializationField =
                                            newValue == '5';
                                      });
                                    },
                                  ),
                                  SizedBox(height: height_ * 0.01),
                                  if (_selectedSpecialization == '5')
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Other Specialization',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _customSpecialization = value;
                                        });
                                      },
                                    ),
                                  SizedBox(height: height_ * 0.014),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Work Experience',
                                      prefixIcon: Icon(Icons.work),
                                      border: OutlineInputBorder(),
                                    ),
                                    value: experience,
                                    items: [
                                      DropdownMenuItem(
                                        value: '6',
                                        child: Text('1-2'),
                                      ),
                                      DropdownMenuItem(
                                        value: '7',
                                        child: Text('3-5'),
                                      ),
                                      DropdownMenuItem(
                                        value: '8',
                                        child: Text('5-10'),
                                      ),
                                      DropdownMenuItem(
                                        value: '9',
                                        child: Text('10+'),
                                      ),
                                    ],
                                    onChanged: (String? Value) {
                                      setState(() {});
                                      experience = Value;
                                    },
                                  ),
                                  SizedBox(height: height_ * 0.025),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                    ),
                                    value: gender,
                                    items: [
                                      DropdownMenuItem(
                                        value: '10',
                                        child: Text('Male'),
                                      ),
                                      DropdownMenuItem(
                                        value: '11',
                                        child: Text('Female'),
                                      ),
                                      DropdownMenuItem(
                                        value: '12',
                                        child: Text('Non-Binary'),
                                      ),
                                    ],
                                    onChanged: (String? Value) {
                                      setState(() {});
                                      gender = Value;
                                    },
                                  ),
                                  SizedBox(height: height_ * 0.02),
                                  Text4(
                                    text:
                                        'Professional Qualification (Certificate)',
                                  ),
                                  SizedBox(height: height_ * 0.01),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        setState(() {
                                          _filePath = result.files.single.path!;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF575ecb)),
                                    ),
                                    child: Text('Select File'),
                                  ),
                                  SizedBox(height: height_ * 0.01),
                                  if (_filePath.isNotEmpty) Text(_filePath),
                                  SizedBox(height: height_ * 0.06),
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
