import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_aware/main.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/auth/introduction/introduction_nutritionist.dart';
import 'package:meal_aware/screen/customer_widget.dart/clientHistory.dart';
import 'package:meal_aware/screen/customer_widget.dart/clientHistoryAppointment.dart';

import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/termsAndContitionHelpPage.dart';

import 'package:meal_aware/screen/customer_widget.dart/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class profileNutritionist extends StatefulWidget {
  const profileNutritionist({super.key});

  @override
  State<profileNutritionist> createState() => _profileNutritionistState();
}

class _profileNutritionistState extends State<profileNutritionist> {
  String _username = '';
  String? imageUrl;
  final picker = ImagePicker();
  String _fullname = '';
  String? _age;
  String? _specialization = '';
  String? _address = '';
  String? _CustomSpecialization = '';
  String? _gender;
  String? _phoneNumber = '';
  String _email = '';

  @override
  void initState() {
    super.initState();

    getAge().then((age) {
      setState(() {
        _age = age;
      });
    });

    getgender().then((gender) {
      setState(() {
        _gender = gender;
      });
    });
    getPhoneNumber().then((phone) {
      setState(() {
        _phoneNumber = phone;
      });
    });

    getUserName().then((username) {
      setState(() {
        _username = username;
      });
    });
    getFullName().then((fullname) {
      setState(() {
        _fullname = fullname;
      });
    });
    getSpecialization().then((specialization) {
      setState(() {
        _specialization = specialization;
      });
    });
    getCustomSpecialization().then((customSpecialization) {
      setState(() {
        _CustomSpecialization = customSpecialization;
      });
    });
    getAddress().then((address) {
      setState(() {
        _address = address;
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

  Future<String> getImageLink() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
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
        .collection('Nutritionist')
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
                  color: Theme.of(context).colorScheme.secondary),
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
                  bottom: 0,
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
            dividingLine1(width_, height_, 0.07),
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
            //
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => clientHistory(),
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Client History Chat',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
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
                    builder: (context) => clientHistoryAppointment(),
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Client History Appointment',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
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
                    builder: (context) => introductionNutritionist(),
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
                    color: Theme.of(context).colorScheme.secondary,
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
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
                    builder: (context) => TermsAndConditionsInHelpPage(),
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: width_ * 0.08),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: width_ * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
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
                    color: Theme.of(context).colorScheme.secondary,
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width_ * 0.07),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width_ * 0.04,
                    ),
                  ),
                ],
              ),
            ),

            dividingLine2(width_, height_, 0),
            Text(
                'If you want to change your information or obtain any information, please contact us:'),
            Text('mealawareness@gmail.com'),
            SizedBox(height: height_ * 0.02),
            listFullname(height_, width_),
            SizedBox(height: height_ * 0.02),
            listEmail(height_, width_),
            SizedBox(height: height_ * 0.02),
            listAge(height_, width_),
            SizedBox(height: height_ * 0.02),
            listGender(height_, width_),
            SizedBox(height: height_ * 0.02),
            listSpecialization(height_, width_),
            SizedBox(height: height_ * 0.02),
            listAddress(height_, width_),
            SizedBox(height: height_ * 0.02),
            listPhoneNumber(height_, width_),

            SizedBox(height: height_ * 0.02),
            dividingLine2(width_, height_, 0),
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
            .collection('Nutritionist')
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
        // margin: EdgeInsets.only(
        //     bottom: height_ * 0.55, left: width_ * 0.1, right: width_ * 0.1),
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
                    Text4(text: 'Nutritionist'),
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

  Widget dividingLine1(double width_, double height_, double height) =>
      Container(
        margin: EdgeInsets.only(
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );
  Widget dividingLine2(double width_, double height_, double height) =>
      Container(
        margin: EdgeInsets.only(
          bottom: height_ * height,
          left: width_ * 0.1,
          right: width_ * 0.1,
        ),
        child: Divider(
          color: Color.fromARGB(255, 86, 86, 86),
          thickness: 1,
        ),
      );

  Future<int> getCoin() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final docSnapshot =
        await FirebaseFirestore.instance.collection('Patient').doc(uid).get();

    if (docSnapshot.exists) {
      return docSnapshot.get('coin');
    } else {
      return 0;
    }
  }

  Future<String> getUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(uid)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('username');
    } else {
      return 'Username';
    }
  }

  Future<String> getFullName() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('fullname');
    } else {
      return 'Username';
    }
  }

  Future<String?> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('age');
    } else {
      return null;
    }
  }

  Future<String?> getgender() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('gender');
    } else {
      return null;
    }
  }

  Future<String?> getSpecialization() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('specialization');
    } else {
      return null;
    }
  }

  Future<String?> getCustomSpecialization() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('customSpecialization');
    } else {
      return null;
    }
  }

  Future<String?> getAddress() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('address');
    } else {
      return null;
    }
  }

  Future<String?> getPhoneNumber() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('phoneNumber');
    } else {
      return null;
    }
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
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _email,
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
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
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (() {
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
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listFullname(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'FullName',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$_fullname',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (() {
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
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listSpecialization(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Specialization',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (() {
                switch (_specialization) {
                  case '1':
                    return 'Sport Nutritionist';
                  case '2':
                    return 'Pediatric Nutritionist';
                  case '3':
                    return 'Clinical Nutritionist';
                  case '4':
                    return 'General Nutritionist';

                  default:
                    return '$_CustomSpecialization';
                }
              }()),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listAddress(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ('$_address'),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listPhoneNumber(
    double height_,
    double width_,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ('$_phoneNumber'),
              style: TextStyle(
                fontSize: width_ * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
