import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class moreinfo extends StatefulWidget {
  final String friendId;
  const moreinfo({super.key, required this.friendId});

  @override
  State<moreinfo> createState() => _moreinfoState(friendId);
}

class _moreinfoState extends State<moreinfo> {
  final String friendId;
  _moreinfoState(this.friendId);

  String _username = '';
  String? _age;

  String? _country;

  String? _gender;
  // late String gender;
  // late String country;

  String? _activityLevel;
  String? _bodyGoal;
  String? _dietType;
  String? _email;
  String? _fullname;
  String? _phonenumber;

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
    getWeight().then((value) {
      setState(() {
        selectedWeight = value;
      });
    });
    getDietaryPreferenceList().then((value) {
      setState(() {
        _dietType = value;
      });
    });

    getUserName().then((value) {
      setState(() {
        _username = value;
      });
    });

    getEmail().then((value) {
      setState(() {
        _email = value;
      });
    });
    getFullname().then((value) {
      setState(() {
        _fullname = value;
      });
    });
    getPhonenumber().then((value) {
      setState(() {
        _phonenumber = value;
      });
    });
    getIdealWeight().then((value) {
      setState(() {
        IdealselectedWeight = value;
      });
    });
    getMealPerDay().then((value) {
      setState(() {
        MealPerDay = value;
      });
    });
    getheight().then((value) {
      setState(() {
        selectedCmHeight = value;
      });
    });
  }

  Future<String> getUserName() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendId)
        .get();

    if (docSnapshot.exists) {
      final username = docSnapshot.get('username');
      return username != null ? username : 'Username';
    } else {
      return 'Username';
    }
  }

  Future<String?> getAge() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
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
        .doc(friendId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('dietaryPreference');
    } else {
      return null;
    }
  }

  Future<String?> getEmail() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('email');
    } else {
      return null;
    }
  }

  Future<String?> getFullname() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('fullname');
    } else {
      return null;
    }
  }

  Future<String?> getPhonenumber() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get('phoneNumber');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String age;

    switch (_age) {
      case '1':
        age = '1-5';
        break;
      case '2':
        age = '6-10';
        break;
      case '3':
        age = '11-15';
        break;
      case '4':
        age = '16-18';
        break;
      case '5':
        age = '6-18';
        break;
      case '6':
        age = '19-24';
        break;
      case '7':
        age = '25-34';
        break;
      case '8':
        age = '35-44';
        break;
      case '9':
        age = '45-54';
        break;
      case '10':
        age = '55-64';
        break;
      case '11':
        age = '65+';
        break;
      default:
        age = '';
        break;
    }
    String country;
    switch (_country) {
      case '1':
        country = 'Mauritius';
        break;
      case '2':
        country = 'Abroad';
        break;
      default:
        country = '';
        break;
    }

    String gender;
    switch (_gender) {
      case '1':
        gender = 'Male';
        break;
      case '2':
        gender = 'Female';
        break;
      case '3':
        gender = 'Non-Binary';
        break;
      default:
        gender = '';
        break;
    }

    String activityLevel;
    switch (_activityLevel) {
      case '1':
        activityLevel = 'Sedentary';
        break;
      case '2':
        activityLevel = 'Light Active';
        break;
      case '3':
        activityLevel = 'Moderately Active';
        break;
      case '4':
        activityLevel = 'Very Active';
        break;
      case '5':
        activityLevel = 'Extremely Active';
        break;
      default:
        activityLevel = '';
        break;
    }

    String bodyGoal;
    switch (_bodyGoal) {
      case '1':
        bodyGoal = 'Muscle Gain';
        break;
      case '2':
        bodyGoal = 'Fat Loss';
        break;
      case '3':
        bodyGoal = 'Maintenance';
        break;
      case '4':
        bodyGoal = 'Rapid Weight Loss';
        break;
      default:
        bodyGoal = '';
        break;
    }

    String dietaryPreference;
    switch (_dietType) {
      case '1':
        dietaryPreference = 'Vegetarian';
        break;
      case '2':
        dietaryPreference = 'Vegan';
        break;
      case '3':
        dietaryPreference = 'Normal';
        break;
      case '4':
        dietaryPreference = 'Gluten-free';
        break;
      case '5':
        dietaryPreference = 'Paleo';
        break;
      case '6':
        dietaryPreference = 'Keto';
        break;
      case '7':
        dietaryPreference = 'Mediterranean';
        break;
      case '8':
        dietaryPreference = 'Pescetarian';
        break;
      default:
        dietaryPreference = '';
        break;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('More Info'),
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Username: $_username'),
              Text(''),
              Text('fullname: $_fullname'),
              Text(''),
              Text('Country: $country'),
              Text(''),
              Text('Email: $_email'),
              Text(''),
              Text('Phone: $_phonenumber'),
              Text(''),
              Text('Age: $age'),
              Text(''),
              Text('Height: $selectedCmHeight cm'),
              Text(''),
              Text('Gender: $gender'),
              Text(''),
              Text('CurrentBody Weight: $selectedWeight kg'),
              Text(''),
              Text('Ideal Weight: $IdealselectedWeight kg'),
              Text(''),
              Text('Body goal: $bodyGoal'),
              Text(''),
              Text('Number of meal per day: $MealPerDay'),
              Text(''),
              Text('Activity level: $activityLevel'),
              Text(''),
              Text('Dietary Preference or restriction: $dietaryPreference'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// void moreInfo(BuildContext context, String friendUid) async {
//   final patientSnapshot = await FirebaseFirestore.instance
//       .collection('Patient')
//       .where('pid', isEqualTo: friendUid)
//       .limit(1)
//       .get();
//   if (patientSnapshot.docs.isNotEmpty) {
//     final patientData = patientSnapshot.docs.first.data();
//     final username = patientData['username'];
//     final fullname = patientData['fullname'];
//     final email = patientData['email'];
//     var age = patientData['age'];
//     final phoneNumber = patientData['phoneNumber'];

//     // Check the value of the specialization field and assign a human-readable label
//     if (age == '1') {
//       age = '1111';
//     } else if (age == '2') {
//       age = '1111';
//     } else if (age == '3') {
//       age = '1111';
//     } else if (age == '4') {
//       age = '11111';
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           title: Text('More Info'),
//           content: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Username: $username'),
//                 Text(''),
//                 Text('Fullname: $fullname'),
//                 Text(''),
//                 Text('Email: $email'),
//                 Text(''),
//                 Text('Phone: $phoneNumber'),
//                 Text(''),
//                 Text('Age: $age'),
//                 Text(''),
//                 Text('Height: '),
//                 Text(''),
//                 Text('Gender: '),
//                 Text(''),
//                 Text('CurrentBody Weight: '),
//                 Text(''),
//                 Text('Number of meal per day: '),
//                 Text(''),
//                 Text('Body goal: '),
//                 Text(''),
//                 Text('Activity level: '),
//                 Text(''),
//                 Text('Dietary Preference or restriction: '),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
