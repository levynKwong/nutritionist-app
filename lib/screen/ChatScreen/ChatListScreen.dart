import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';

class ChatListScreen extends StatelessWidget {
  final chatStream = FirebaseFirestore.instance
      .collection('chats')
      .where('users', arrayContains: currentId)
      .orderBy('lastMessageTime', descending: true)
      .snapshots();

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
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
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
              final friendUid = docs[index]['users'][0];
              final friendName = docs[index]['usernames'][0];
              final lastMessage = docs[index]['lastMessage'];
              final lastMessageTime = docs[index]['lastMessageTime'];

              return Card(
                child: Container(
                  color: Color.fromARGB(255, 242, 243, 251),
                  width: width_ * 0.9, // Change the width to your liking
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150?img=3'),
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
                          builder: (context) => ChatDetail(
                            friendUid: friendUid,
                            friendName: friendName,
                          ),
                        ),
                      );
                    },
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
