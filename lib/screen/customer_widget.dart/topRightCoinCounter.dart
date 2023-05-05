import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class topRightCounter extends StatefulWidget {
  const topRightCounter({super.key});

  @override
  State<topRightCounter> createState() => _topRightCounterState();
}

class _topRightCounterState extends State<topRightCounter> {
  int _coin = 0;

  @override
  void initState() {
    super.initState();
    getCoin().then((coin) {
      setState(() {
        _coin = coin;
      });
    });
  }

  FutureBuilder<int> getCoinWidget() {
    return FutureBuilder<int>(
      future: getCoin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a CircularProgressIndicator while waiting for the data to load
          return CircularProgressIndicator();
        } else {
          // The data has loaded, so return the result
          int coin = snapshot.data ?? 0;
          return Text('Coin: $coin');
        }
      },
    );
  }

  Future<int> getCoin() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final docSnapshot =
        await FirebaseFirestore.instance.collection('Patient').doc(uid).get();

    if (docSnapshot.exists) {
      return docSnapshot.get('coin');
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        top: height_ * 0.02,
        // left: width_ * 0.8,
        right: width_ * 0.02,
      ),
      width: width_ * 0.18,
      height: height_ * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFa9c3f4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/token_.png',
            width: width_ * 0.08,
            height: height_ * 0.02,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(height: 10),
          Text(
            '$_coin',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
