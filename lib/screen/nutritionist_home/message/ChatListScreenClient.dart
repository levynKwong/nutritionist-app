import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:meal_aware/screen/nutritionist_home/message/chatDetailClient.dart';

class ChatListScreenClient extends StatefulWidget {
  const ChatListScreenClient({Key? key}) : super(key: key);

  @override
  _ChatListScreenClientState createState() => _ChatListScreenClientState();
}

class _ChatListScreenClientState extends State<ChatListScreenClient> {
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

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('Patient')
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
                  child: CircularProgressIndicator(),
                );
              }
              final docsNutritionist = snapshot.data!.docs;

              if (docsNutritionist.isEmpty) {
                return Center(
                  child: Text('No chats found'),
                );
              }
              return ListView.builder(
                itemCount: docsNutritionist.length,
                itemBuilder: (BuildContext context, int index) {
                  final friendUid = docsNutritionist[index].id;
                  final friendName = docsNutritionist[index]['username'];
                  final lastMessage = docs.firstWhere(
                    (doc) => doc['users'].contains(friendUid),
                  )['lastMessage'];

                  final lastMessageTime = docs.firstWhere(
                    (doc) => doc['users'].contains(friendUid),
                  )['lastMessageTime'];

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
                              DateFormat.jm().format(lastMessageTime!.toDate()),
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
                              builder: (context) => ChatDetailClient(
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
