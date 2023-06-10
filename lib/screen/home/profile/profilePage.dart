import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/main.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/customer_widget.dart/appointment_history.dart';
import 'package:meal_aware/screen/customer_widget.dart/helpPagePatient.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/order.dart';
import 'package:meal_aware/screen/customer_widget.dart/ordersHistory.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';

import 'package:meal_aware/screen/home/profile/BuyToken/BuyCoin.dart';
import 'package:meal_aware/screen/home/profile/BuyToken/GetCoin.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int _coin = 0;
  int _totalAmount = 0;
  int _totalAmountAppointment = 0;
  final picker = ImagePicker();
  String? imageUrl;
  String _username = '';
  String? _fullname;
  String? _age;

  String? _country;

  String? _gender;
  // late String gender;
  // late String country;
  String _email = '';

  String? _activityLevel;
  String? _bodyGoal;
  String? _dietType;
  String? _phoneNumber;

  List<int> cmHeights = List.generate(
      200,
      (index) =>
          index +
          0); // Create a list of integers representing the available height options in centimeters

  int? selectedCmHeight;
  List<int> Weight = List.generate(
      150,
      (index) =>
          index +
          0); // Create a list of integers representing the available height options in centimeters

  int? selectedWeight;
  int? IdealselectedWeight;
  List<int> IdealWeight = List.generate(150, (index) => index + 0);
  int? MealPerDay;
  List<int> meal = List.generate(10, (index) => index + 0);

  Future<String> getImageLink() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      final image_url = docSnapshot.get('image_url');
      return image_url != null
          ? image_url + '?scale=0.5'
          : 'image_url'; // Adjust the scale value as needed
    } else {
      return 'image_url';
    }
  }

  Future<String> getEmail() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      final email = docSnapshot.get('email');
      return email != null
          ? email
          : 'email'; // Adjust the scale value as needed
    } else {
      return 'email';
    }
  }

  @override
  void initState() {
    super.initState();

    getAge().then((value) {
      setState(() {
        _age = value;
      });
    });
    getCountry().then((value) {
      setState(() {
        _country = value;
      });
    });
    getGender().then((value) {
      setState(() {
        _gender = value;
      });
    });
    getActivityLevel().then((value) {
      setState(() {
        _activityLevel = value;
      });
    });
    getBodyGoal().then((value) {
      setState(() {
        _bodyGoal = value;
      });
    });
    getDietaryPreferenceList().then((value) {
      setState(() {
        _dietType = value;
      });
    });
    getCoin().then((coin) {
      setState(() {
        _coin = coin;
      });
    });
    getUserName().then((value) {
      setState(() {
        _username = value;
      });
    });
    getTotalAmount().then((value) {
      setState(() {
        _totalAmount = value;
      });
    });
    getFullname().then((value) {
      setState(() {
        _fullname = value;
      });
    });
    getphoneNumber().then((value) {
      setState(() {
        _phoneNumber = value;
      });
    });
    getTotalAmountAppointment().then((value) {
      setState(() {
        _totalAmountAppointment = value;
      });
    });
    getImageLink().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
    getEmail().then((email) {
      setState(() {
        _email = email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBarTop(
        titleText: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SizedBox(
            width: width_,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height_ * 0.01),
                topContent(height_, width_),
                SizedBox(height: height_ * 0.01),
                buildProfileHeader(width_, height_),
                SizedBox(height: height_ * 0.02),
                Content(width_, height_)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topContent(double height_, double width_) => Container(
        width: double.infinity,
        child: Stack(
          children: [
            topTitle(height_, width_),
          ],
        ),
      );
  Widget topTitle(double height_, double width_) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height_ * 0.01),
            Text(
              '$_username',
              style: TextStyle(
                  fontSize: width_ * 0.1,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: height_ * 0.01),
            Text(
              'Username',
              style: TextStyle(
                  fontSize: width_ * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 132, 132, 132)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader(double width_, double height_) => Center(
        child: Column(
          children: [
            Stack(
              children: [
                buildProfile(width_, height_),
                Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget Content(double width_, double height_) => Container(
        child: Column(
          children: [
            topRow(width_, height_),
            SizedBox(height: height_ * 0.02),
            dividingLine1(width_, height_),
            SizedBox(height: height_ * 0.01),
            bottomRow(width_, height_),
            SizedBox(height: height_ * 0.01),
            dividingLine1(width_, height_),
            selector(height_, width_),
          ],
        ),
      );

  Widget logout(double height_) => Container(
        child: TextButton.icon(
          onPressed: () async {
            FirebaseAuth.instance.signOut();

            // Remove saved login credentials from shared preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear(); // This will remove all shared preferences

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false,
            );
          },
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          label: Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 233, 58, 58),
            ),
          ),
        ),
      );

  Widget selector(double height_, double width_) => Container(
        margin: EdgeInsets.only(left: width_ * 0.1, right: width_ * 0.1),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetCoin(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/tokenIcon.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Get Coin',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.06),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersHistory(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/to-do-list.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Purchase History',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => appointmentHistory(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/to-do-list.png',
                    height: height_ * 0.1,
                    width: width_ * 0.1,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Appointment History',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPagePatient(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: width_ * 0.1,
                    color: Colors.black,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Help',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => introductionNutritionist(),
                //   ),
                // );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width_ * 0.8, height_ * 0.07),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.supervised_user_circle,
                    size: width_ * 0.1,
                    color: Colors.black,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 86, 86, 86),
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            dividingLine2(width_, height_),
            // username(height_, width_),
            FullName(height_, width_),
            SizedBox(height: height_ * 0.01),
            phonenumber(height_, width_),
                 SizedBox(height: height_ * 0.01),
            listEmail(height_, width_),
            listAge(height_, width_),
            listCountry(height_, width_),
            listGender(height_, width_),
            listHeight(height_, width_),
            listweight(height_, width_),
            listIdealweight(height_, width_),
            listMealPerDay(height_, width_),
            listActivityLevel(height_, width_),
            listBodyGoal(height_, width_),
            listDietaryPreference(height_, width_),
            SizedBox(height: height_ * 0.02),
            dividingLine2(width_, height_),
            logout(height_),
          ],
        ),
      );

  Widget buildProfile(double width_, double height_) {
    Future<void> uploadImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Uploading the image to Firebase Storage
        var file = File(pickedFile.path);
        var fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.png';
        var storageReference = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(fileName);
        var uploadTask = storageReference.putFile(file);

        // Retrieving the download URL
        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the download URL in the "Patient" collection (with merge option)
        var patientData = {
          'image_url': downloadUrl.toString(),
          // Add other patient data as needed
        };
        await FirebaseFirestore.instance
            .collection('Patient')
            .doc(currentId) // Replace with the appropriate patient document ID
            .set(patientData, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Your picture has been uploaded, it will take some time to load it'),
          ),
        );
      }
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: width_ * 0.18,
          backgroundColor: Color.fromARGB(255, 130, 130, 130),
          child: ClipOval(
            child: SizedBox(
              width: width_ * 0.32,
              height: width_ * 0.32,
              child: imageUrl != null
                  ? FadeInImage(
                      placeholder: AssetImage('images/OIB.png'),
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'images/OIB.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                uploadImage();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget topRow(double width_, double height_) => Container(
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Age'),
                    SizedBox(height: height_ * 0.01),
                    Text4(
                      text: (() {
                        switch (_age) {
                          case '1':
                            return '1-5';
                          case '2':
                            return '6-10';
                          case '3':
                            return '11-15';
                          case '4':
                            return '16-18';
                          case '5':
                            return '6-18';
                          case '6':
                            return '19-24';
                          case '7':
                            return '25-34';
                          case '8':
                            return '35-44';
                          case '9':
                            return '45-54';
                          case '10':
                            return '55-64';
                          case '11':
                            return '65+';
                          default:
                            return '';
                        }
                      }()),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color.fromARGB(255, 86, 86, 86),
                thickness: 1,
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Status'),
                    SizedBox(height: height_ * 0.01),
                    Text4(text: 'Patient'),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color.fromARGB(255, 86, 86, 86),
                thickness: 1,
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text3(text: 'Gender'),
                    SizedBox(height: height_ * 0.01),
                    Text4(
                      text: (() {
                        switch (_gender) {
                          case '1':
                            return 'Male';
                          case '2':
                            return 'Female';
                          case '3':
                            return 'Non-binary';

                          default:
                            return '';
                        }
                      }()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bottomRow(double width_, double height_) {
    int total = _totalAmount + _totalAmountAppointment;
    return Container(
      margin: EdgeInsets.only(
        left: width_ * 0.1,
        right: width_ * 0.1,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        SizedBox(width: width_ * 0.04),
                        Image.asset(
                          'images/token_.png',
                          width: width_ * 0.08,
                          height: height_ * 0.08,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: width_ * 0.04),
                        Text3(text: 'Coin'),
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.0001),
                  Center(
                    child: Text4(text: '$_coin'),
                  ),
                ],
              ),
            ),
            SizedBox(width: width_ * 0.04),
            VerticalDivider(
              color: Color.fromARGB(255, 86, 86, 86),
              thickness: 1,
              width: 8,
            ),
            SizedBox(width: width_ * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        SizedBox(width: width_ * 0.04),
                        Image.asset(
                          'images/order.png',
                          width: width_ * 0.08,
                          height: height_ * 0.08,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: width_ * 0.04),
                        Text3(text: 'Orders'),
                      ],
                    ),
                  ),
                  SizedBox(height: height_ * 0.0001),
                  Center(
                    child: Text4(text: '$total'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dividingLine1(double width_, double height_) => Container(
        margin: EdgeInsets.only(
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );
  Widget dividingLine2(double width_, double height_) => Container(
        margin: EdgeInsets.only(
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );

  Future<int> getCoin() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('coin');
    } else {
      return 0;
    }
  }

  Future<String> getUserName() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      final username = docSnapshot.get('username');
      return username != null ? username : 'Username';
    } else {
      return 'Username';
    }
  }

  final List<DropdownMenuItem<String>> ageList = [
    DropdownMenuItem(
      value: '3',
      child: Text('13-15'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('16-18'),
    ),
    // DropdownMenuItem(
    //   value: '5',
    //   child: Text('13-18'),
    // ),
    DropdownMenuItem(
      value: '6',
      child: Text('19-24'),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('25-34'),
    ),
    DropdownMenuItem(
      value: '8',
      child: Text('35-44'),
    ),
    DropdownMenuItem(
      value: '9',
      child: Text('45-54'),
    ),
    DropdownMenuItem(
      value: '10',
      child: Text('55-64'),
    ),
    DropdownMenuItem(
      value: '11',
      child: Text('65+'),
    ),
  ];
  final List<DropdownMenuItem<String>> countryList = [
    DropdownMenuItem(
      value: '1',
      child: Text('Mauritius'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Abroad'),
    ),
  ];
  final List<DropdownMenuItem<String>> genderList = [
    DropdownMenuItem(
      value: '1',
      child: Text('        Male'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('       Female'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('   Non-Binary'),
    ),
  ];

  final List<DropdownMenuItem<String>> activityLevelList = [
    DropdownMenuItem(
      value: '1',
      child: Text('Sedentary'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Light Active'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Moderately Active'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Very Active'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('Extremely Active'),
    ),
  ];

  final List<DropdownMenuItem<String>> BodyGoalList = [
    DropdownMenuItem(
      value: '1',
      child: Text('Muscle Gain'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Fat Loss'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Maintenance'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Rapid Weight Loss'),
    ),
  ];

  final List<DropdownMenuItem<String>> DietaryPreferenceList = [
    DropdownMenuItem(
      value: '1',
      child: Text('Vegetarian'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Vegan'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Normal'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Gluten-free'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('Paleo'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('Keto'),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('Mediterranean'),
    ),
    DropdownMenuItem(
      value: '8',
      child: Text('Pescetarian'),
    ),
  ];

  Future<String?> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('age');
    } else {
      return null;
    }
  }

  Future<String?> getCountry() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    String? country;
    if (docSnapshot.exists) {
      country = docSnapshot.get('Country');
    } else {
      country = null;
    }

    return country;
  }

  Future<String?> getGender() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    String? gender;
    if (docSnapshot.exists) {
      gender = docSnapshot.get('gender');
    } else {
      gender = null;
    }

    return gender;
  }

  Future<int?> getheight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('Height');
    } else {
      return null;
    }
  }

  Future<int?> getWeight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('Weight');
    } else {
      return null;
    }
  }

  Future<int?> getIdealWeight() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('IdealWeight');
    } else {
      return null;
    }
  }

  Future<int?> getMealPerDay() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('MealPerDay');
    } else {
      return null;
    }
  }

  Future<String?> getActivityLevel() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      final activityLevel = docSnapshot.get('selectedActivityLevel') as String?;
      return activityLevel;
    } else {
      return null;
    }
  }

  Future<String?> getBodyGoal() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('selectedBodyGoal');
    } else {
      return null;
    }
  }

  Future<String?> getDietaryPreferenceList() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('dietaryPreference');
    } else {
      return null;
    }
  }

  Future<String?> getFullname() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('fullname');
    } else {
      return null;
    }
  }

  Future<String?> getphoneNumber() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('phoneNumber');
    } else {
      return null;
    }
  }

  Widget username(
    double height_,
    double width_,
  ) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '$_username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (String? newValue) async {
                      setState(() {
                        _username = newValue!;
                      });

                      await FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(currentId)
                          .update({'username': newValue}).then((value) {
                        print('Country updated');
                        _username =
                            newValue!; // Update _country with the new value
                      }).catchError((error) =>
                              print('Failed to update country: $error'));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget FullName(
    double height_,
    double width_,
  ) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height_ * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '$_fullname',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (String? newValue) async {
                      setState(() {
                        _fullname = newValue!;
                      });

                      await FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(currentId)
                          .update({'fullname': newValue}).then((value) {
                        print('Country updated');
                        _fullname =
                            newValue; // Update _country with the new value
                      }).catchError((error) =>
                              print('Failed to update country: $error'));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget phonenumber(
    double height_,
    double width_,
  ) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'phone number',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height_ * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '$_phoneNumber',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (String? newValue) async {
                      setState(() {
                        _phoneNumber = newValue!;
                      });

                      await FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(currentId)
                          .update({'phoneNumber': newValue}).then((value) {
                        print('Country updated');
                        _phoneNumber =
                            newValue; // Update _country with the new value
                      }).catchError((error) =>
                              print('Failed to update country: $error'));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listAge(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Age',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _age,
                  items: ageList,
                  onChanged: (String? newValue) {
                    // update the age value when the user selects an item
                    setState(() {
                      _age = newValue!;
                    });
                    FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(
                            currentId) // Replace "patientId" with the ID of the current patient
                        .update({'age': newValue})
                        .then((value) => print('Age updated'))
                        .catchError(
                            (error) => print('Failed to update age: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listCountry(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Country',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _country,
                  items: countryList,
                  onChanged: (String? newValue) async {
                    setState(() {
                      _country = newValue;
                    });

                    await FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(currentId)
                        .update({'Country': newValue}).then((value) {
                      print('Country updated');
                      _country = newValue; // Update _country with the new value
                    }).catchError((error) =>
                            print('Failed to update country: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listGender(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Gender',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _gender,
                  items: genderList,
                  onChanged: (String? newValue) async {
                    setState(() {
                      _gender = newValue;
                    });

                    await FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(currentId)
                        .update({'gender': newValue}).then((value) {
                      print('Gender updated');
                      _gender = newValue; // Update _gender with the new value
                    }).catchError((error) =>
                            print('Failed to update gender: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listHeight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getheight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          selectedCmHeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Height',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: selectedCmHeight,
                      items: cmHeights.map((int height) {
                        return DropdownMenuItem<int>(
                          value: height,
                          child: Text("$height cm"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          selectedCmHeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(currentId)
                            .update({'Height': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listweight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getWeight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          selectedWeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: selectedWeight,
                      items: Weight.map((int weight) {
                        return DropdownMenuItem<int>(
                          value: weight,
                          child: Text("$weight kg"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          selectedWeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(currentId)
                            .update({'Weight': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listIdealweight(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getIdealWeight(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          IdealselectedWeight =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Ideal Weight',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: IdealselectedWeight,
                      items: IdealWeight.map((int IdealWeight) {
                        return DropdownMenuItem<int>(
                          value: IdealWeight,
                          child: Text("$IdealWeight kg"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          IdealselectedWeight = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(currentId)
                            .update({'IdealWeight': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listMealPerDay(
    double height_,
    double width_,
  ) {
    return FutureBuilder<int?>(
      future: getMealPerDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          MealPerDay =
              snapshot.data ?? 0; // Set the initial value of selectedCmHeight
        }
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Meal per day',
                  style: TextStyle(
                    fontSize: width_ * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: MealPerDay,
                      items: meal.map((int meal) {
                        return DropdownMenuItem<int>(
                          value: meal,
                          child: Text("$meal"),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        // update the height value when the user selects an item
                        setState(() {
                          MealPerDay = newValue!;
                        });
                        FirebaseFirestore.instance
                            .collection('Patient')
                            .doc(currentId)
                            .update({'MealPerDay': newValue})
                            .then((value) => print('Height updated'))
                            .catchError((error) =>
                                print('Failed to update height: $error'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listActivityLevel(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Activity Level',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _activityLevel,
                  items: activityLevelList,
                  onChanged: (String? newValue) async {
                    setState(() {
                      _activityLevel = newValue;
                    });

                    await FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(currentId)
                        .update({'activityLevel': newValue}).then((value) {
                      print('Activity Level updated');
                      _activityLevel =
                          newValue; // Update _activityLevel with the new value
                    }).catchError((error) =>
                            print('Failed to update activity level: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listBodyGoal(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Body Goal',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                    value: _bodyGoal,
                    items: BodyGoalList,
                    onChanged: (String? newValue) async {
                      setState(() {
                        _bodyGoal = newValue;
                      });

                      await FirebaseFirestore.instance
                          .collection('Patient')
                          .doc(currentId)
                          .update({'bodyGoal': newValue}).then((value) {
                        print('Body Goal updated');
                        _bodyGoal =
                            newValue; // Update _bodyGoal with the new value
                      }).catchError((error) =>
                              print('Failed to update body goal: $error'));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listDietaryPreference(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Dietary Preference',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _dietType,
                  items: DietaryPreferenceList,
                  onChanged: (String? newValue) async {
                    setState(() {
                      _dietType = newValue;
                    });

                    await FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(currentId)
                        .update({'dietaryPreference': newValue}).then((value) {
                      print('Dietary Preference updated');
                      _dietType =
                          newValue; // Update _dietaryPreference with the new value
                      // ignore: invalid_return_type_for_catch_error
                    }).catchError((error) => print(
                            'Failed to update dietary preference: $error'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listEmail(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Email',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _email,
              style: TextStyle(
                fontSize: width_ * 0.04,
                
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
