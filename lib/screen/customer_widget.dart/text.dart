import 'package:flutter/material.dart';

class Text1 extends StatelessWidget {
  final String text;
  const Text1({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Text2 extends StatelessWidget {
  final String text;
  const Text2({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Text3 extends StatelessWidget {
  final String text;
  const Text3({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Text4 extends StatelessWidget {
  final String text;
  const Text4({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            // fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Text5 extends StatelessWidget {
  final String text;
  const Text5({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.040,
            // fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 75, 75, 75),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Text6 extends StatelessWidget {
  final String text;
  const Text6({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Text7 extends StatelessWidget {
  final String text;
  const Text7({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.055,
            // fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
