import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/reportButton.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatBubble.dart';

class ChatDetailClient extends StatefulWidget {
  final friendUid;
  final friendName;

  const ChatDetailClient({Key? key, this.friendUid, this.friendName})
      : super(key: key);

  @override
  State<ChatDetailClient> createState() =>
      _ChatDetailClientState(friendUid, friendName);
}

class _ChatDetailClientState extends State<ChatDetailClient> {
  final messageController = TextEditingController();
  CollectionReference chats =
      FirebaseFirestore.instance.collection('chatNutritionist');
  final String friendUid;
  final String friendName;

  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  bool isTextFieldInFocus = false;
  var chatDocId;
  _ChatDetailClientState(this.friendUid, this.friendName);
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
          'users': [currentUserId, friendUid]
        });
        final docId = docRef.id;
        setState(() {
          this.chatDocId = docId;
        });
        prefs.setString('chatDocId', docId);

        // Send initial message
        sendMessage('Hi, Please to meet you Dr $friendName');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chatNutritionist")
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NutritionistHome(),
                      ),
                    )
                  },
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150?img=3'),
                    ),
                    SizedBox(width: width_ * 0.03),
                    Text('${widget.friendName}'),
                  ],
                ),
                backgroundColor: getColor(),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: height_ * 0.01, top: height_ * 0.01),
                    child: Container(
                      height: height_ * 0.05,
                      width: width_ * 0.15,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(231, 53, 63, 201),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        child: Text(
                          'Info',
                          style: TextStyle(
                            color: Color.fromARGB(255, 231, 231, 231),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          moreInfo();
                        },
                      ),
                    ),
                  ),
                  ReportButton(
                    userId: userId,
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
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 125,
                            child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type a message',
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 12, top: 15, right: 15),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {},
                                  //   icon: const Icon(Icons.emoji_emotions),
                                  // ),
                                ),
                              ),
                            )),
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
                        )
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
    final chatRef = FirebaseFirestore.instance
        .collection('chatNutritionist')
        .doc(chatDocId);

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

  void moreInfo() async {
    final patientSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .where('uid', isEqualTo: friendUid)
        .limit(1)
        .get();
    if (patientSnapshot.docs.isNotEmpty) {
      final patientData = patientSnapshot.docs.first.data();
      final username = patientData['username'];
      final fullname = patientData['fullname'];
      final email = patientData['email'];
      var age = patientData['age'];
      final phoneNumber = patientData['phoneNumber'];

      // Check the value of the specialization field and assign a human-readable label
      if (age == '1') {
        age = '1111';
      } else if (age == '2') {
        age = '1111';
      } else if (age == '3') {
        age = '1111';
      } else if (age == '4') {
        age = '11111';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('More Info'),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Username: $username'),
                  Text(''),
                  Text('Fullname: $fullname'),
                  Text(''),
                  Text('Email: $email'),
                  Text(''),
                  Text('Phone: $phoneNumber'),
                  Text(''),
                  Text('Age: $age'),
                  Text(''),
                  Text('Height: '),
                  Text(''),
                  Text('Gender: '),
                  Text(''),
                  Text('CurrentBody Weight: '),
                  Text(''),
                  Text('Number of meal per day: '),
                  Text(''),
                  Text('Body goal: '),
                  Text(''),
                  Text('Activity level: '),
                  Text(''),
                  Text('Dietary Preference or restriction: '),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
