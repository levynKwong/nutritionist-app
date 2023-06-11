import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuButtonNutritionist extends StatefulWidget {
  final String userId;
  final String friendId;

  MenuButtonNutritionist({required this.userId, required this.friendId});

  @override
  _MenuButtonNutritionistState createState() => _MenuButtonNutritionistState();
}

class _MenuButtonNutritionistState extends State<MenuButtonNutritionist> {
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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            loadData(); // Load the data when entering the dialog

            return AlertDialog(
              title: Text('View Answers'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < questions.length; i++)
                    ListTile(
                      title: Text(questions[i]),
                      subtitle: TextFormField(
                        initialValue: answers.length > i ? answers[i] : '',
                        decoration: InputDecoration(
                          labelText: 'Answer',
                          enabled: false, // Disable editing
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
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
