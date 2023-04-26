import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meal_aware/screen/home/Doctor_forum/ChatDoctor/newScreen.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String email;
  const WebViewScreen({Key? key, required this.url, required this.email})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    // Construct the URL of the Google Form with the email parameter
    String url = widget.url;
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'entry.1FAIpQLSeDKt0gHqp4sfbkwbGixqzpLtBWIJEEGQl78r98IO7Y5oieLQ': widget
          .email, // replace '1234567890' with the actual ID of the email field in your form
    });
    String urlWithEmail = uri.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF989efd),
        title: Text('Google Form'),
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => newScreen(),
    ));
  }
}
