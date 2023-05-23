import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';

class ChatListScreenNutritionist extends StatefulWidget {
  @override
  _ChatListScreenNutritionistState createState() =>
      _ChatListScreenNutritionistState();
}

class _ChatListScreenNutritionistState
    extends State<ChatListScreenNutritionist> {
  final chatStream = FirebaseFirestore.instance
      .collection('chatNutritionist')
      .where('users', arrayContains: currentId)
      .orderBy('lastMessageTime', descending: true)
      .snapshots();

  Map<String, int> unreadMessagesCountMap = {};

  @override
  void initState() {
    super.initState();
    // getUnreadMessagesCount();
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.01, left: width_ * 0.02, right: width_ * 0.02),
      child: StreamBuilder<QuerySnapshot>(
        stream: chatStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Loading...'),
            );
          }

          final docs = snapshot.data?.docs;

          if (docs == null || docs.isEmpty) {
            return Center(
              child: Text('No chats found'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              final friendUid = currentId == docs[index]['users'][0]
                  ? docs[index]['users'][1]
                  : docs[index]['users'][0];

              final friendName = currentId == docs[index]['users'][0]
                  ? docs[index]['usernames'][1]
                  : docs[index]['usernames'][0];
              final lastMessage = docs[index]['lastMessage'];
              final lastMessageTime = docs[index]['lastMessageTime'];
              final chatId = docs[index].id;
              final unreadMessages = docs[index]['unreadMessages'] ?? [];

              return Card(
                child: Container(
                  color: Color.fromARGB(255, 242, 243, 251),
                  width: width_ * 0.9, // Change the width to your liking
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('images/OIB.png'),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            friendName,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          lastMessageTime != null
                              ? DateFormat.jm().format(lastMessageTime.toDate())
                              : '',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      lastMessage,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailNutritionist(
                            friendUid: friendUid,
                            friendName: friendName,
                          ),
                        ),
                      );
                    },
                    trailing: Visibility(
                      visible: unreadMessages == 2,
                      child: Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
