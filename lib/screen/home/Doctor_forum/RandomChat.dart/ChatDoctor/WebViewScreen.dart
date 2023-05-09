import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/paymentChat.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String email;
  final String nutritionistId;
  final String nutritionistName;

  const WebViewScreen(
      {Key? key,
      required this.url,
      required this.email,
      required this.nutritionistId,
      required this.nutritionistName})
      : super(key: key);

  @override
  State<WebViewScreen> createState() =>
      _WebViewScreenState(url, email, nutritionistId, nutritionistName);
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String nutritionistId;
  final String nutritionistName;
  final String url;
  final String email;
  bool _formSubmitted = false;
  _WebViewScreenState(
      this.url, this.email, this.nutritionistId, this.nutritionistName);
  @override
  Widget build(BuildContext context) {
    // Construct the URL of the Google Form with the email parameter
    String url = widget.url;
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'entry.1962223544': widget
          .email, // replace '1234567890' with the actual ID of the email field in your form
    });
    String urlWithEmail = uri.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(),
        title: Text('Google Form'),
        automaticallyImplyLeading: false,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(urlWithEmail)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            userAgent:
                'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36',
          ),
        ),
        onLoadStop: (controller, url) {
          // Listen for form submissions and call _onFormSubmitted
          if (url.toString().contains('formResponse')) {
            _onFormSubmitted();
          }
        },
      ),
    );
  }

  void _onFormSubmitted() {
    if (!_formSubmitted) {
      _formSubmitted = true;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatDetailNutritionist(
              friendUid: nutritionistId, friendName: nutritionistName)));
    }
  }
}
