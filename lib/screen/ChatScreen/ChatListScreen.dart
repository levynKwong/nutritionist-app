import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .where('users', arrayContains: currentUserId)
          .orderBy("lastMessageTime", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            String friendUid = data['users']
                .firstWhere((key, value) => key != currentUserId)
                .key;
            String friendName = data['userNames']
                .firstWhere((key, value) => key != currentUserId)
                .value;
            String lastMessage = data['lastMessage'];
            Timestamp? lastMessageTime = data['lastMessageTime'] as Timestamp?;
            String time = lastMessageTime != null
                ? DateFormat.jm().format(lastMessageTime.toDate()).toString()
                : '';
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=3'),
              ),
              title: Text(friendName),
              subtitle: Text(lastMessage),
              trailing: Text(time),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetail(
                        friendUid: friendUid, friendName: friendName),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
