import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/reportButton.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatBubble.dart';

class ChatDetail extends StatefulWidget {
  final friendUid;
  final friendName;
  const ChatDetail({Key? key, this.friendUid, this.friendName})
      : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState(friendUid, friendName);
}

class _ChatDetailState extends State<ChatDetail> {
  final messageController = TextEditingController();
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final String friendUid;
  final String friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  bool isTextFieldInFocus = false;
  var chatDocId;
  _ChatDetailState(this.friendUid, this.friendName);
  @override
  void initState() {
    super.initState();
    _getChatDocId();
  }

  Future<void> _getChatDocId() async {
    final prefs = await SharedPreferences.getInstance();

    if (chatDocId != null) {
      setState(() {
        this.chatDocId = chatDocId;
      });
    } else {
      final snapshot = await chats
          .where('users', whereIn: [
            [currentUserId, friendUid],
            [friendUid, currentUserId],
          ])
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.single.id;
        setState(() {
          this.chatDocId = docId;
        });
        prefs.setString('chatDocId', docId);
      } else {
        final docRef = await chats.add({
          'users': [currentUserId, friendUid],
        });
        final docId = docRef.id;
        setState(() {
          this.chatDocId = docId;
        });
        prefs.setString('chatDocId', docId);

        final currentUserSnapshot = await FirebaseFirestore.instance
            .collection('Patient')
            .doc(currentUserId)
            .get();
        final friendSnapshot = await FirebaseFirestore.instance
            .collection('Patient')
            .doc(friendUid)
            .get();

        String currentUserName = currentUserSnapshot['username'];
        String friendName = friendSnapshot['username'];

        chats.doc(docId).update({
          'usernames': [currentUserName, friendName],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .doc(chatDocId)
            .collection("messages")
            .orderBy("createdOn", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Something went wrong"),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            });
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              !isTextFieldInFocus) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/OIB.png'),
                    ),
                    SizedBox(width: width_ * 0.03),
                    Text(
                      '${widget.friendName}',
                    ),
                  ],
                ),
                backgroundColor: getColor(),
                actions: [
                  ReportButton(
                    userId: currentId,
                    friendId: friendUid,
                  ),
                ],
              ),
              body: Container(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String message = data['msg'];
                            Timestamp? createdOn =
                                data['createdOn'] as Timestamp?;
                            String time = createdOn != null
                                ? DateFormat.jm()
                                    .format(createdOn.toDate())
                                    .toString()
                                : '';
                            bool isMe = data['uid'] == currentUserId;

                            return ChatBubble(
                              message: message,
                              time: time,
                              isMe: isMe,
                              friendUid: friendUid,
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Not Available"),
                                  content: Text(
                                      "For the security of our users, this feature is not available."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.add),
                          color: const Color.fromARGB(
                              255, 0, 0, 0), // Change the button color to blue
                          disabledColor: Colors
                              .grey, // Change the button color when it's disabled
                          // Disable the button and display "not available"
                          tooltip: "This button is not available",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 125,
                          child: Card(
                            margin:
                                EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: GestureDetector(
                              onLongPress: () {
                                final text = messageController.text;
                                if (text.isNotEmpty) {
                                  final overlay = Overlay.of(context)
                                      .context
                                      .findRenderObject() as RenderBox?;
                                  if (overlay != null) {
                                    final position = RelativeRect.fromRect(
                                      Offset.zero & overlay.size,
                                      Offset.zero & overlay.size,
                                    );
                                    showMenu(
                                      context: context,
                                      position: position,
                                      items: [
                                        PopupMenuItem(
                                          child: Text('Copy'),
                                          onTap: () {
                                            Clipboard.setData(
                                                ClipboardData(text: text));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Text copied to clipboard')),
                                            );
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: Text('Paste'),
                                          onTap: () async {
                                            final clipboardData =
                                                await Clipboard.getData(
                                                    Clipboard.kTextPlain);
                                            if (clipboardData != null) {
                                              final clipboardText =
                                                  clipboardData.text;
                                              setState(() {
                                                messageController.text =
                                                    clipboardText!;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                }
                              },
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    isTextFieldInFocus = true;
                                  });
                                },
                                onFieldSubmitted: (_) {
                                  setState(() {
                                    isTextFieldInFocus = false;
                                  });
                                },
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                minLines: 1,
                                enabled: true, // Enable copy and paste
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type a message',
                                  contentPadding: EdgeInsets.only(
                                    left: 15,
                                    bottom: 12,
                                    top: 15,
                                    right: 15,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.emoji_emotions),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: Color(0xFF575dcb),
                          radius: 22.5,
                          child: IconButton(
                            onPressed: () {
                              sendMessage(messageController.text);
                            },
                            icon: const Icon(Icons.send_rounded),
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Placeholder();
          }
        });
  }

  void sendMessage(String msg) {
    if (msg == '') return;

    // Get the chat document reference
    final chatRef =
        FirebaseFirestore.instance.collection('chats').doc(chatDocId);

    // Add the message to the messages collection in the chat document
    chatRef.collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg,
    }).then((value) {
      // Update the lastMessage and lastMessageTime fields in the chat document
      chatRef.update({
        'lastMessage': msg,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });

      // Clear the message input field
      messageController.text = '';
    });
  }
}
