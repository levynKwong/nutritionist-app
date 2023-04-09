import 'package:flutter/material.dart';

class DoctorForum extends StatelessWidget {
  const DoctorForum({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
