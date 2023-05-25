import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String email;
  final String nid;
  final String nutritionistName;

  const WebViewScreen({
    Key? key,
    required this.url,
    required this.email,
    required this.nid,
    required this.nutritionistName,
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() =>
      _WebViewScreenState(url, email, nid, nutritionistName);
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String nid;
  final String nutritionistName;
  final String url;
  final String email;
  bool _formSubmitted = false;

  _WebViewScreenState(this.url, this.email, this.nid, this.nutritionistName);

  String entryId = '';

  @override
  void initState() {
    super.initState();
    fetchEditFormData();
  }

  void fetchEditFormData() {
    FirebaseFirestore.instance
        .collection('Nutritionist')
        .doc(nid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Object? data = documentSnapshot.data();
        String? fetchedID =
            (data as Map<String, dynamic>)['entryId'] as String?;
        setState(() {
          entryId = fetchedID!;
        });
      }
    }).catchError((error) {
      print('Error fetching editForm data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      entryId: widget.email,
    });
    String urlWithEmail = uri.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(),
        title: Text('Google Form'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(urlWithEmail)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              userAgent:
                  'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36',
            ),
          ),
          onLoadStop: (controller, url) {
            if (url.toString().contains('formResponse')) {
              _onFormSubmitted();
            }
          },
        ),
      ),
    );
  }

  void _onFormSubmitted() async {
    if (!_formSubmitted) {
      _formSubmitted = true;

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('payments')
            .where('nid', isEqualTo: nid)
            .where('pid', isEqualTo: currentId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          DocumentReference docRef = documentSnapshot.reference;

          await docRef.update({'progress': 2});

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatDetailNutritionist(
                  friendUid: nid, friendName: nutritionistName)));
        } else {
          print('Document not found');
        }
      } catch (error) {
        print('Error updating progress: $error');
      }
    }
  }
}
