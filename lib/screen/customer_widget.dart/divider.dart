import 'package:flutter/material.dart';

class divider extends StatefulWidget {
  const divider({super.key});

  @override
  State<divider> createState() => _dividerState();
}

class _dividerState extends State<divider> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Divider(
      color: Color(0xFFd9f2ff),
      thickness: height_ * 0.001,
      indent: width_ * 0.1,
      endIndent: width_ * 0.1,
    );
  }
}
