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
      appBar: AppBar(title: Text('Nutritionist Form')),
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
            nid: nid,
            name: name,
            questions: questions,
          );
        },
      ),
    );
  }
}

class NutritionistQuestionsForm extends StatefulWidget {
  final String nid;
  final String name;
  final List<String> questions;

  NutritionistQuestionsForm({
    required this.nid,
    required this.name,
    required this.questions,
  });

  @override
  _NutritionistQuestionsFormState createState() =>
      _NutritionistQuestionsFormState();
}

class _NutritionistQuestionsFormState extends State<NutritionistQuestionsForm>
    with AutomaticKeepAliveClientMixin {
  late Map<String, String> answers;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    answers = {};
    for (String question in widget.questions) {
      answers[question] = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure that the super.build method is called

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
              child: ListView.separated(
                itemCount: widget.questions.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  String question = widget.questions[index];
                  return ListTile(
                    title: Text(question),
                    subtitle: TextFormField(
                      initialValue: answers[question], // Set initial value
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          answers[question] = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  submitForm();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    List<String> answersList =
        widget.questions.map((question) => answers[question]!).toList();

    FirebaseFirestore.instance
        .collection('Forms')
        .where('nid', isEqualTo: widget.nid)
        .where('pid', isEqualTo: currentId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size > 0) {
        // Document already exists, update it
        querySnapshot.docs.first.reference.set(
          {
            'answers': answersList,
          },
          SetOptions(merge: true),
        ).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form updated successfully')),
          );

          // Navigate to the appropriate screen
          navigateToChatDetail();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        });
      } else {
        // Document doesn't exist, create a new one
        FirebaseFirestore.instance.collection('Forms').add(
          {
            'answers': answersList,
            'nid': widget.nid,
            'pid': currentId,
          },
        ).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted successfully')),
          );

          // Navigate to the appropriate screen
          navigateToChatDetail();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        });
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  void navigateToChatDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailNutritionist(
          friendUid: widget.nid,
          friendName: widget.name,
        ),
      ),
    );
  }
}
