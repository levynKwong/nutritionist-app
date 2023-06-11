import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';

class NutritionistForm extends StatelessWidget {
  final String nid;
  final String name;

  NutritionistForm({required this.nid, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopBack(titleText: 'Nutritionist Form'),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Nutritionist')
            .doc(nid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No nutritionist found'));
          }

          List<String> questions = List<String>.from(
              (snapshot.data!.data() as Map<String, dynamic>)['questions'] ??
                  []);

          return NutritionistQuestionsForm(
              nid: nid, name: name, questions: questions);
        },
      ),
    );
  }
}

class NutritionistQuestionsForm extends StatefulWidget {
  final String nid;
  final String name;
  final List<String> questions;

  NutritionistQuestionsForm(
      {required this.nid, required this.name, required this.questions});

  @override
  _NutritionistQuestionsFormState createState() =>
      _NutritionistQuestionsFormState();
}

class _NutritionistQuestionsFormState extends State<NutritionistQuestionsForm> {
  late List<String> answers;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    answers = List<String>.filled(widget.questions.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nutritionist name: ${widget.name}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Questions:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.questions[index]),
                    subtitle: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        answers[index] = value;
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Validate form before submitting
                if (_formKey.currentState!.validate()) {
                  // Submit form and save data to Firebase
                  submitForm();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: getColor(), // Set the desired background color
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    // Save data to Firebase
    FirebaseFirestore.instance.collection('Forms').doc().set(
      {
        'answers': answers,
        'nid': widget.nid,
        'pid': currentId,
      },
      SetOptions(merge: true), // Merge the new data with existing document
    ).then((value) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully'),
        ),
      );
      //navigate to another page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailNutritionist(
            friendUid: widget.nid,
            friendName: widget.name,
          ),
        ),
      );
    }).catchError((error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    });
  }
}
