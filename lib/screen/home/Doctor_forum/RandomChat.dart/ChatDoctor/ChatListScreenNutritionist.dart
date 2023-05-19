import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';

class ChatListScreenNutritionist extends StatelessWidget {
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
              child: Text('Loading...'),
            );
          }

          final docs = snapshot.data?.docs;

          if (docs == null || docs.isEmpty) {
            return Center(
              child: Text('No chats found'),
            );
          }

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('Nutritionist')
                .where(FieldPath.documentId,
                    whereIn: docs.map((doc) {
                      final friendUid = doc['users'].cast<String>().firstWhere(
                          (uid) => uid != currentUserId,
                          orElse: () => '');
                      return friendUid;
                    }).toList())
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Card(
                  child: ListTile(
                    title: Text('Error'),
                    subtitle: Text('Could not load name'),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              }
              final docsNutritionist = snapshot.data!.docs;

              if (docsNutritionist.isEmpty) {
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
                          backgroundImage: AssetImage('images/photoCat.png'),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Dr ' + friendName,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              lastMessageTime != null
                                  ? DateFormat.jm()
                                      .format(lastMessageTime.toDate())
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
