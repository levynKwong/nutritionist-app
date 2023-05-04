import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';
import 'dart:async';

import 'package:meal_aware/screen/home/Doctor_forum/ChatDoctor/chatDetailNutritionist.dart';

class ChatListScreenNutritionist extends StatefulWidget {
  const ChatListScreenNutritionist({Key? key}) : super(key: key);

  @override
  _ChatListScreenNutritionistState createState() =>
      _ChatListScreenNutritionistState();
}

class _ChatListScreenNutritionistState
    extends State<ChatListScreenNutritionist> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          top: height_ * 0.01, left: width_ * 0.02, right: width_ * 0.02),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatNutritionist')
            .where('users', arrayContains: currentUserId)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(
              child: Text('No chats found'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              final doc = docs[index];
              final friendUid = doc['users']
                  .cast<String>()
                  .firstWhere((uid) => uid != currentUserId, orElse: () => '');

              final lastMessage = doc['lastMessage'];
              final lastMessageTime = doc['lastMessageTime'] != null
                  ? (doc['lastMessageTime'] as Timestamp).toDate()
                  : null;

              if (friendUid == null) {
                return Container();
              }

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Nutritionist')
                    .doc(friendUid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Card(
                      child: ListTile(
                        title: Text('Error'),
                        subtitle: Text('Could not load name'),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Card(
                      child: ListTile(
                        title: Text('Loading...'),
                        subtitle: Text(''),
                      ),
                    );
                  }

                  final friendName = snapshot.data!['username'];

                  return Card(
                    child: Container(
                      color: Color.fromARGB(255, 242, 243, 251),
                      width:
                          width_ * 0.2, // Set a fixed width for the container
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=3'),
                        ),
                        title: Row(children: [
                          Text('Dr ' + friendName),
                          SizedBox(width: width_ * 0.35),
                          Text(
                            DateFormat.jm().format(lastMessageTime!),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ]),
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
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
