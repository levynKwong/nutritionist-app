import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MoreInfoDashboardList extends StatefulWidget {
  final List<String> friendId;

  const MoreInfoDashboardList({Key? key, required this.friendId})
      : super(key: key);

  @override
  State<MoreInfoDashboardList> createState() => _MoreInfoDashboardListState();
}

class _MoreInfoDashboardListState extends State<MoreInfoDashboardList> {
  late String _username = ''; // Initialize with default value
  late String _age = '';
  late String _country = '';
  late String _gender = '';
  late String _activityLevel = '';
  late String _bodyGoal = '';
  late String _dietType = '';
  late String _email = '';
  late String _fullname = '';
  late String _phonenumber = '';
  late int selectedCmHeight = 0;
  late int selectedWeight = 0;
  int? idealSelectedWeight;
  int? mealPerDay;

  List<int> cmHeights = List.generate(200, (index) => index + 0);
  List<int> weights = List.generate(150, (index) => index + 0);
  List<int> idealWeights = List.generate(150, (index) => index + 0);
  List<int> mealOptions = List.generate(10, (index) => index + 0);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final snapshots = widget.friendId.map(
        (id) => FirebaseFirestore.instance.collection('Patient').doc(id).get());

    final docSnapshots = await Future.wait(snapshots);

    for (final snapshot in docSnapshots) {
      if (snapshot.exists) {
        _username = snapshot.get('username') ?? 'Username';
        _age = convertAge(snapshot.get('age'));
        _country = convertCountry(snapshot.get('Country'));
        _gender = convertGender(snapshot.get('gender'));
        _activityLevel =
            convertActivityLevel(snapshot.get('selectedActivityLevel'));
        _bodyGoal = convertBodyGoal(snapshot.get('selectedBodyGoal'));
        _dietType = convertDietaryPreference(snapshot.get('dietaryPreference'));
        _email = snapshot.get('email') ?? '';
        _fullname = snapshot.get('fullname') ?? '';
        _phonenumber = snapshot.get('phoneNumber') ?? '';
        selectedCmHeight = snapshot.get('Height') ?? 0;
        selectedWeight = snapshot.get('Weight') ?? 0;
        idealSelectedWeight = snapshot.get('IdealWeight');
        mealPerDay = snapshot.get('MealPerDay');
      }
    }

    setState(() {});
  }

  String convertAge(String? ageValue) {
    switch (ageValue) {
      case '1':
        return '1-5';
      case '2':
        return '6-10';
      case '3':
        return '13-15';
      case '4':
        return '16-17';
      case '5':
        return '13-17';
      case '6':
        return '18-24';
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
  }

  String convertCountry(String? countryValue) {
    switch (countryValue) {
      case '1':
        return 'Mauritius';
      case '2':
        return 'Abroad';
      default:
        return '';
    }
  }

  String convertGender(String? genderValue) {
    switch (genderValue) {
      case '1':
        return 'Male';
      case '2':
        return 'Female';
      case '3':
        return 'Non-Binary';
      default:
        return '';
    }
  }

  String convertActivityLevel(String? activityLevelValue) {
    switch (activityLevelValue) {
      case '1':
        return 'Sedentary';
      case '2':
        return 'Lightly Active';
      case '3':
        return 'Moderately Active';
      case '4':
        return 'Very Active';
      case '5':
        return 'Extremely Active';
      default:
        return '';
    }
  }

  String convertBodyGoal(String? bodyGoalValue) {
    switch (bodyGoalValue) {
      case '1':
        return 'Muscle Gain';
      case '2':
        return 'Fat Loss';
      case '3':
        return 'Maintenance';
      case '4':
        return 'Rapid Weight Loss';
      default:
        return '';
    }
  }

  String convertDietaryPreference(String? dietaryPreferenceValue) {
    switch (dietaryPreferenceValue) {
      case '1':
        return 'Vegetarian';
      case '2':
        return 'Vegan';
      case '3':
        return 'Normal';
      case '4':
        return 'Gluten-Free';
      case '5':
        return 'Paleo';
      case '6':
        return 'Keto';
      case '7':
        return 'Mediterranean';
      case '8':
        return 'Pescetarian';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('More Info'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Username: $_username'),
          Text('Age: $_age'),
          Text('Country: $_country'),
          Text('Gender: $_gender'),
          Text('Activity Level: $_activityLevel'),
          Text('Body Goal: $_bodyGoal'),
          Text('Dietary Preference: $_dietType'),
          Text('Email: $_email'),
          Text('Full Name: $_fullname'),
          Text('Phone Number: $_phonenumber'),
          Text('Height: $selectedCmHeight cm'),
          Text('Weight: $selectedWeight kg'),
          if (idealSelectedWeight != null)
            Text('Ideal Weight: $idealSelectedWeight kg'),
          if (mealPerDay != null) Text('Meals per Day: $mealPerDay'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
