import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuButton extends StatefulWidget {
  final String userId;
  final String friendId;

  MenuButton({required this.userId, required this.friendId});

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference nutritionistsCollection =
      FirebaseFirestore.instance.collection('Nutritionist');
  CollectionReference formsCollection =
      FirebaseFirestore.instance.collection('Forms');

  List<String> questions = [];
  List<String> answers = [];
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadData() async {
    if (!dataLoaded) {
      await Future.wait([
        loadQuestions(),
        loadAnswers(),
      ]);
      dataLoaded = true;
      setState(() {}); // Refresh the UI after data is loaded
    }
  }

  Future<void> loadQuestions() async {
    try {
      DocumentSnapshot nutritionistSnapshot =
          await nutritionistsCollection.doc(widget.friendId).get();

      if (nutritionistSnapshot.exists) {
        questions = List<String>.from(
            (nutritionistSnapshot.data() as Map<String, dynamic>)['questions']);
      }
    } catch (error) {
      // Handle error
      print('Error loading questions: $error');
    }
  }

  Future<void> loadAnswers() async {
    try {
      QuerySnapshot formSnapshot = await formsCollection
          .where('pid', isEqualTo: widget.userId)
          .where('nid', isEqualTo: widget.friendId)
          .get();

      if (formSnapshot.docs.isNotEmpty) {
        DocumentSnapshot formDoc = formSnapshot.docs.first;
        answers = List<String>.from(
            (formDoc.data() as Map<String, dynamic>)['answers']);
      }
    } catch (error) {
      // Handle error
      print('Error loading answers: $error');
    }
  }

  Future<void> saveAnswers() async {
    try {
      QuerySnapshot formSnapshot = await formsCollection
          .where('pid', isEqualTo: widget.userId)
          .where('nid', isEqualTo: widget.friendId)
          .get();

      if (formSnapshot.docs.isNotEmpty) {
        DocumentSnapshot formDoc = formSnapshot.docs.first;
        String formId = formDoc.id;

        // Save the updated answers to Firebase
        await formsCollection.doc(formId).set(
          {
            'answers': answers,
          },
          SetOptions(merge: true), // Use SetOptions with merge: true
        );
      }
    } catch (error) {
      // Handle error
      print('Error saving answers: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            loadData(); // Load the data when entering the dialog

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Form'),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < questions.length; i++)
                            ListTile(
                              title: Text(questions[i]),
                              subtitle: TextFormField(
                                initialValue:
                                    answers.length > i ? answers[i] : '',
                                decoration: InputDecoration(
                                  labelText: 'Enter an answer',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an answer';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    answers[i] = value;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          // Save the answers
                          saveAnswers();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Icon(Icons.menu),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
