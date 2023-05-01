import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/ChatScreen/chatDetail.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .where("users",
                arrayContains: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No chats found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final doc = snapshot.data!.docs[index];
              final friendUid = doc.get("users").firstWhere(
                  (uid) => uid != FirebaseAuth.instance.currentUser?.uid);
              final friendName = doc.get("friendName");

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=$index"),
                ),
                title: Text(friendName),
                subtitle: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .doc(doc.id)
                      .collection("messages")
                      .orderBy("createdOn", descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox.shrink();
                    }

                    final data = snapshot.data!.docs.first.data()
                        as Map<String, dynamic>;
                    final message = data["msg"] ?? "";
                    final isMe =
                        data["uid"] == FirebaseAuth.instance.currentUser?.uid;

                    return Text(
                      isMe ? "You: $message" : message,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
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
              );
            },
          );
        },
      ),
    );
  }
}
