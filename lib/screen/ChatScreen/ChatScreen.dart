import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.userId, required this.userName})
      : super(key: key);

  final String userId;
  final String userName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // Implement the chat screen UI here
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
      ),
      body: Center(
        child: Text('Chatting with ${widget.userName} (ID: ${widget.userId})'),
      ),
    );
  }
}
