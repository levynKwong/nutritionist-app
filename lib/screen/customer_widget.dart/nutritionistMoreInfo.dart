import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/text.dart';

class NutritionistMoreInfo extends StatelessWidget {
  final String nid;
  const NutritionistMoreInfo({super.key, required this.nid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopBack(
        titleText: 'More info',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16), // Add spacing if needed
              Text(
                'More info about the nutritionist',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Nutritionist')
                    .doc(nid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('No data found');
                  }

                  // Retrieve the "More info" array from the document
                  final moreInfo =
                      snapshot.data!.get('moreInfo') as List<dynamic>;

                  // Display the content of the "More info" array
                  return Column(
                    children: moreInfo
                        .map<Widget>((item) => ListTile(
                              title: Text(item.toString()),
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
