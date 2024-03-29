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
    final bool isSmallScreen =
        width_ < 600; // Adjust this value as needed for small screens

    return Container(
      
      margin: EdgeInsets.only(
          top: height_ * 0.01,
          left: 10.0,
          right: 10.0), // Adjust the margins as needed
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
              child: Text(''),
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
              // final unreadMessages = docs[index]['unreadMessages'] ?? [];

              return Card(
                child: Container(
                  
                  width: isSmallScreen
                      ? width_
                      : width_ * 0.9, // Adjust the width based on screen size
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: isSmallScreen
                          ? 20.0
                          : 30.0, // Adjust the avatar size based on screen size
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
