import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/chatDetailNutritionist.dart';
import 'package:meal_aware/screen/nutritionist_home/message/chatDetailClient.dart';

class ChatListScreenNutritionist extends StatelessWidget {
  final chatStream = FirebaseFirestore.instance
      .collection('chatNutritionist')
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
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
              // Retrieve the necessary data for each chat item
              final friendUid = currentId == docs[index]['users'][0]
                  ? docs[index]['users'][1]
                  : docs[index]['users'][0];

              final friendName = currentId == docs[index]['users'][0]
                  ? docs[index]['usernames'][1]
                  : docs[index]['usernames'][0];

              final lastMessage = docs[index]['lastMessage'];
              final lastMessageTime = docs[index]['lastMessageTime'];
              final unreadMessages = docs[index]['unreadMessages'] ?? [];

              // Retrieve the image URL for the friend
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Nutritionist')
                    .doc(friendUid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the data to load, return a placeholder ListTile
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: isSmallScreen ? 20.0 : 30.0,
                          backgroundImage: AssetImage('images/OIB.png'),
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
                        trailing: Visibility(
                          visible: unreadMessages == 2,
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
                    );
                  }

                  if (snapshot.hasError) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: isSmallScreen ? 20.0 : 30.0,
                          backgroundImage: AssetImage('images/OIB.png'),
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
                        trailing: Visibility(
                          visible: unreadMessages == 2,
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
                    );
                  }

                  final nutritionistData =
                      snapshot.data?.data() as Map<String, dynamic>;
                  final imageUrl = nutritionistData['image_url'];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: isSmallScreen ? 20.0 : 30.0,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl) as ImageProvider<Object>?
                            : AssetImage('images/OIB.png'),
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
                      trailing: Visibility(
                        visible: unreadMessages == 2,
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
