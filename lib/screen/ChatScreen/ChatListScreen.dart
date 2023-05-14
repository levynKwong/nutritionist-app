import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with AutomaticKeepAliveClientMixin<ChatListScreen> {
  late SharedPreferences _prefs;
  List<String> _cachedFriendNames = [];
  List<DocumentSnapshot> _docs = [];
  List<DocumentSnapshot> _docsNutritionist = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _loadData();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final cachedFriendNamesJson = _prefs.getString('cachedFriendNames');
    if (cachedFriendNamesJson != null) {
      setState(() {
        _cachedFriendNames =
            List<String>.from(jsonDecode(cachedFriendNamesJson));
      });
    }
  }

  Future<void> _cacheFriendNames(List<String> friendNames) async {
    setState(() {
      _cachedFriendNames = friendNames;
    });
    await _prefs.setString('cachedFriendNames', jsonEncode(friendNames));
  }

  List<String> _getCachedFriendNames(List<String> friendUids) {
    final Map<String, String> friendUidToName = Map.fromIterables(
      _cachedFriendNames.map((name) => name.split('###')[0]),
      _cachedFriendNames,
    );
    return friendUids
        .map((uid) => friendUidToName[uid] ?? 'Unknown User')
        .toList();
  }

  Future<void> _loadData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .get();

    final docs = snapshot.docs;

    final friendUids = docs
        .map((doc) =>
            doc['users'].cast<String>().firstWhere((uid) => uid != userId))
        .toList();

    final nutritionistSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .where(FieldPath.documentId, whereIn: friendUids)
        .get();

    if (mounted) {
      setState(() {
        _docs = docs;
        _docsNutritionist = nutritionistSnapshot.docs;
      });
    }

    @override
    Widget build(BuildContext context) {
      super.build(context); // required for AutomaticKeepAliveClientMixin
      final double width_ = MediaQuery.of(context).size.width;
      final double height_ = MediaQuery.of(context).size.height;
      return Container(
        margin: EdgeInsets.only(
            top: height_ * 0.01, left: width_ * 0.02, right: width_ * 0.02),
        child: _docsNutritionist.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _docsNutritionist.length,
                itemBuilder: (BuildContext context, int index) {
                  final friendUid = _docsNutritionist[index].id;
                  final friendName = _docsNutritionist[index]['username'];
                  final lastMessage = _docs.firstWhere(
                    (doc) => doc['users'].contains(friendUid),
                  )['lastMessage'];

                  final lastMessageTime = _docs.firstWhere(
                    (doc) => doc['users'].contains(friendUid),
                  )['lastMessageTime'];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=3'),
                      ),
                      title: Text(friendName),
                      subtitle: Text(lastMessage),
                      trailing: Text(
                        lastMessageTime != null
                            ? DateFormat.jm().format(lastMessageTime.toDate())
                            : '',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatDetail(
                              friendUid: friendUid,
                              friendName: friendName,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      );
    }
  }
}

/// A cache for storing and retrieving friend names.
