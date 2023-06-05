import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

class form extends StatefulWidget {
  final String url;

  const form({Key? key, required this.url}) : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  late InAppWebViewController _formController;

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(),
        automaticallyImplyLeading: false,
        title: Text('Enter your questions :'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _formController.reload();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: InAppWebView(
        key: UniqueKey(), // add a key
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            userAgent:
                'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36',
          ),
        ),
        onLoadStop: (controller, url) {
          // Listen for form submissions
          if (url.toString().contains('formResponse')) {
            // Handle form submission here
          }
        },
        onWebViewCreated: (controller) {
          _formController = controller;
        },
      ),
    );
  }
}
