import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getCachedCoin().then((coin) {
      setState(() {
        _coin = coin;
      });
      // Now fetch the updated value from Firebase in the background
      getCoin().then((newCoin) {
        setState(() {
          _coin = newCoin;
        });
      }).catchError((error) {
        // Handle error when Firebase fails to fetch data
        print('Error fetching coin value from Firebase: $error');
      });
    }).catchError((error) {
      // Handle error when Shared Preferences fails to fetch data
      print('Error fetching cached coin value: $error');
    });
  }

  Future<int> getCachedCoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('coin') ?? 0;
  }

  FutureBuilder<int> getCoinWidget() {
    return FutureBuilder<int>(
      future: getCoin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a CircularProgressIndicator while waiting for the data to load
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error when fetching data from Firebase
          print('Error fetching coin value from Firebase: ${snapshot.error}');
          return Text('Error loading coin value');
        } else {
          // The data has loaded, so return the result
          int coin = snapshot.data ?? 0;
          return Text('Coin: $coin');
        }
      },
    );
  }

  Future<int> getCoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? cachedCoin = prefs.getInt('coin');

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Patient')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        int coin = docSnapshot.get('coin');
        // cache the value using shared preferences
        await prefs.setInt('coin', coin);
        return coin;
      } else {
        return cachedCoin ?? 0;
      }
    } catch (error) {
      // Handle error when Firebase fails to fetch data
      print('Error fetching coin value from Firebase: $error');
      return cachedCoin ?? 0;
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
