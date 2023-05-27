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
  late Stream<QuerySnapshot> chatStream;
  Map<String, int> unreadMessagesCountMap = {};
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    chatStream = FirebaseFirestore.instance
        .collection('chatNutritionist')
        .where('users', arrayContains: currentId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
    // getUnreadMessagesCount();
    getImageLink().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  Future<String> getImageLink() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(currentId)
        .get();

    if (docSnapshot.exists) {
      final image_url = docSnapshot.get('image_url');
      return image_url != null ? image_url : 'image_url';
    } else {
      return 'image_url';
    }
  }

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Return an empty container while loading
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
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

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Nutritionist')
                    .doc(friendUid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(); // Return an empty container while loading
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final nutritionistData =
                      snapshot.data?.data() as Map<String, dynamic>;

                  final imageUrl = nutritionistData['image_url'];

                  return Card(
                    child: Container(
                      color: Color.fromARGB(255, 242, 243, 251),
                      width: isSmallScreen
                          ? width_
                          : width_ *
                              0.9, // Adjust the width based on screen size
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: isSmallScreen
                              ? 20.0
                              : 30.0, // Adjust the avatar size based on screen size
                          backgroundImage: imageUrl != null
                              ? NetworkImage(imageUrl!)
                                  as ImageProvider<Object>?
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
