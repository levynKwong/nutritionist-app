import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoinCounter extends StatefulWidget {
  const CoinCounter({Key? key}) : super(key: key);

  @override
  State<CoinCounter> createState() => _CoinCounterState();
}

class _CoinCounterState extends State<CoinCounter> {
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
        bottom: height_ * 0.5,
        left: width_ * 0.1,
        right: width_ * 0.1,
      ),
      child: Center(
        child: SizedBox(
          height: height_ * 0.15,
          width: width_ * 0.6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFa9c3f4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Your Coin:",
                    style: TextStyle(
                      fontSize: width_ * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/token_.png',
                          width: width_ * 0.08,
                          height: height_ * 0.08,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: width_ * 0.1),
                        Text(
                          "$_coin",
                          style: TextStyle(
                            fontSize: width_ * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
