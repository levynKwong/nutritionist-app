import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/navBar.dart';
import 'package:meal_aware/screen/customer_widget.dart/reportButton.dart';
import 'package:meal_aware/screen/home/Doctor_forum/BookAppointment/SelectionDate.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/paymentChat.dart';
import 'package:meal_aware/screen/home/Doctor_forum/RandomChat.dart/ChatDoctor/paymentChatNoForm.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatBubble.dart';

class ChatDetailNutritionist extends StatefulWidget {
  final friendUid;
  final friendName;

  const ChatDetailNutritionist({Key? key, this.friendUid, this.friendName})
      : super(key: key);

  @override
  State<ChatDetailNutritionist> createState() =>
      _ChatDetailNutritionistState(friendUid, friendName);
}

class _ChatDetailNutritionistState extends State<ChatDetailNutritionist> {
  final messageController = TextEditingController();
  CollectionReference chats =
      FirebaseFirestore.instance.collection('chatNutritionist');
  final String friendUid;
  final String friendName;

  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  bool isTextFieldInFocus = false;
  var chatDocId;
  _ChatDetailNutritionistState(this.friendUid, this.friendName);
  bool sendButtonEnabled = true;
  // Timestamp? lastMessageTimestamp;
  void _toggleButton() {
    setState(() {
      sendButtonEnabled = false;
    });
  }

  void _toggleButton2() {
    setState(() {
      sendButtonEnabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getChatDocId();
    checkPaymentStatus();
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

  void checkPaymentStatus() {
    final now = DateTime.now();
    final twoMinutesAgo = now.subtract(Duration(minutes: 2));

    FirebaseFirestore.instance
        .collection('payments')
        .where('uid', isEqualTo: uid)
        .where('nutritionistId', isEqualTo: friendUid)
        .where('status', isEqualTo: 1)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        DateTime paymentDate = DateTime.parse(doc['date'].toDate().toString());
        if (paymentDate.isBefore(twoMinutesAgo)) {
          FirebaseFirestore.instance
              .collection('payments')
              .doc(doc.id)
              .update({'status': 0})
              .then((value) => _toggleButton())
              .catchError((error) => print('Failed to update payment: $error'));
        }
      });
    });
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
                        builder: (context) => Home(),
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
                    Text('Dr ' + '${widget.friendName}'),
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
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.emoji_emotions),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: sendButtonEnabled == true
                              ? Color(0xFF575dcb)
                              : Colors.grey,
                          radius: 22.5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (sendButtonEnabled == true) {
                                    sendMessage(messageController.text);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Payment Required"),
                                          content: Text(
                                              "Please make a payment to unlock this feature."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        paymentChatNoForm(
                                                      nutritionistId: friendUid,
                                                      nutritionistName:
                                                          friendName,
                                                    ),
                                                  ),
                                                );
                                                _toggleButton2();
                                              },
                                              child:
                                                  Text("Do you want to pay?"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                icon: Visibility(
                                  visible: sendButtonEnabled == true,
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: sendButtonEnabled == false,
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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

    // Check if it's been more than 1 minute since the last payment

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
    final nutritionistSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .where('uid', isEqualTo: friendUid)
        .limit(1)
        .get();
    if (nutritionistSnapshot.docs.isNotEmpty) {
      final nutritionistData = nutritionistSnapshot.docs.first.data();
      final username = nutritionistData['username'];
      final email = nutritionistData['email'];
      final address = nutritionistData['address'];
      final phoneNumber = nutritionistData['phoneNumber'];
      var specialization = nutritionistData['specialization'];
      var gender = nutritionistData['gender'];
      final customSpecialization = nutritionistData['customSpecialization'];

      // Check the value of the specialization field and assign a human-readable label
      if (specialization == '1') {
        specialization = 'Sport Nutritionist';
      } else if (specialization == '2') {
        specialization = 'Pediatric Nutritionist';
      } else if (specialization == '3') {
        specialization = 'Clinical Nutritionist';
      } else if (specialization == '4') {
        specialization = 'General Nutritionist';
      } else {
        specialization = customSpecialization;
      }
      if (gender == '10') {
        gender = 'Male';
      } else if (gender == '11') {
        gender = 'Female';
      } else if (gender == '12') {
        gender = 'Non-Binary';
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
                  Text('UserName: Dr $username'),
                  Text(''),
                  Text('Email: $email'),
                  Text(''),
                  Text('Address of work: $address'),
                  Text(''),
                  Text('Phone: $phoneNumber'),
                  Text(''),
                  Text('Specialization: $specialization'),
                  Text(''),
                  Text('Gender: $gender'),
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
