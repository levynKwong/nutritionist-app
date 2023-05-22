import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/CoinCounter.dart';

import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/purchase.dart';
import 'package:meal_aware/screen/customer_widget.dart/reportButton.dart';

import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:meal_aware/screen/ChatScreen/chatBubble.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

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
  bool showButtons = false;
  File? selectedImage;

  File? selectedFile;
  @override
  void initState() {
    super.initState();
    _getChatDocId();
    checkStatus();
    startPaymentStatusChecker();
    changeUnreadMessage();
  }

  void _toggleButton(bool enabled) {
    setState(() {
      sendButtonEnabled = enabled;
    });
  }

// Add this line after obtaining the imageUrl
  void changeUnreadMessage() async {
    final snapshot = await chats
        .where('users', whereIn: [
          [currentUserId, friendUid],
          [friendUid, currentUserId],
        ])
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.single.id;

      await chats.doc(docId).update({'unreadMessages': 0});
    }
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
          'unreadMessages': 1
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
            .collection('Nutritionist')
            .doc(friendUid)
            .get();

        String currentUserName = currentUserSnapshot['username'];
        String friendName = friendSnapshot['username'];

        chats.doc(docId).update({
          'usernames': [currentUserName, friendName],
        });

        sendMessage('Hi, Please to meet you Dr $friendName');
      }
    }
  }

  void checkStatus() {
    FirebaseFirestore.instance
        .collection('payments')
        .where('pid', isEqualTo: currentId)
        .where('nid', isEqualTo: friendUid)
        .where('status', isEqualTo: 1)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _toggleButton(true);
      } else {
        _toggleButton(false);
      }
    }).catchError((error) {
      // Handle error during status check
      print('Error checking status: $error');
    });
  }

  void startPaymentStatusChecker() {
    Timer.periodic(Duration(days: 1), (Timer timer) {
      checkPaymentStatus();
    });
  }

  void checkPaymentStatus() {
    final now = DateTime.now();
    final twoMinutesAgo = now.subtract(Duration(days: 1));

    FirebaseFirestore.instance
        .collection('payments')
        .where('nid', isEqualTo: friendUid)
        .where('pid', isEqualTo: currentId)
        .where('status', isEqualTo: 1)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        DateTime paymentDate = doc['date'].toDate();
        if (paymentDate.isBefore(twoMinutesAgo) && doc['status'] == 1) {
          FirebaseFirestore.instance
              .collection('payments')
              .doc(doc.id)
              .update({'status': 0}).then((_) {
            checkStatus();
            print('Payment status updated to 0');
          }).catchError((error) {
            print('Failed to update payment status: $error');
          });
        }
      }
    }).catchError((error) {
      // Handle error during payment status check
      print('Error checking payment status: $error');
    });
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 10),
      ),
    );
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
                      backgroundImage: AssetImage('images/OIB.png'),
                    ),
                    SizedBox(width: width_ * 0.03),
                    Expanded(
                      // Wrap Text widget with Expanded
                      child: Text(
                        'Dr ' + '${widget.friendName}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
                          // Add any other desired text styles
                        ),
                      ),
                    ),
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
                                  title: Text('Add Media'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text('Add Image'),
                                        onTap: () async {
                                          final picker = ImagePicker();
                                          final pickedImage =
                                              await picker.getImage(
                                                  source: ImageSource.gallery);

                                          if (pickedImage != null) {
                                            // Call a function to upload the image and send it as a message
                                            sendMessageWithImage(
                                                File(pickedImage.path));
                                            Navigator.pop(context);

                                            // Show a SnackBar to indicate the image upload completion
                                            showSnackBar(context,
                                                'Image uploaded successfully wait a few seconds to load');
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.attach_file),
                                        title: Text('Add File'),
                                        onTap: () async {
                                          final result = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'pdf',
                                              'doc',
                                              'docx',
                                              'txt'
                                            ],
                                          );

                                          if (result != null) {
                                            // Call a function to upload the file and send it as a message
                                            sendMessageWithFile(File(
                                                result.files.single.path!));
                                            Navigator.pop(context);

                                            // Show a SnackBar to indicate the file upload completion
                                            showSnackBar(context,
                                                'File uploaded successfully wait a few seconds to load');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.add),
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
                                                Navigator.of(context).pop();

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Pay"),
                                                      content: Text(
                                                          "Are you sure you want to make a payment?"),
                                                      actions: [
                                                        CoinCounter(),
                                                        Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center, // Align buttons in the center
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    "Cancel"),
                                                              ),
                                                              SizedBox(
                                                                  width: width_ *
                                                                      0.07), // Put 1 sized box between the buttons
                                                              TextButton(
                                                                onPressed: () {
                                                                  deductCoin(
                                                                      context,
                                                                      friendUid);
                                                                  _toggleButton(
                                                                      true);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  ChatDetailNutritionist(
                                                                    friendUid:
                                                                        friendUid,
                                                                    friendName:
                                                                        friendName,
                                                                  );
                                                                },
                                                                child: Text(
                                                                    "Confirm"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
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
        'unreadMessages': 1
      });

      // Clear the message input field
      messageController.text = '';
    });
  }

  void sendMessageWithImage(File image) async {
    // Get the chat document reference
    final chatRef = FirebaseFirestore.instance
        .collection('chatNutritionist')
        .doc(chatDocId);

    // Determine the image file extension
    String extension = image.path.split('.').last.toLowerCase();

    // Generate a unique file name for the image based on the current timestamp
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.$extension';

    // Upload the image file to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = storageRef.putFile(image);
    final storageSnapshot = await uploadTask.whenComplete(() => null);
    final imageUrl = await storageSnapshot.ref.getDownloadURL();

    // Determine the image type based on the file extension
    String imageType = getFileTypeFromExtension(extension);

    // Add the image message to the messages collection in the chat document
    chatRef.collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': imageUrl, // Store the direct image URL
      'type': imageType,
    }).then((value) {
      // Update the lastMessage and lastMessageTime fields in the chat document
      chatRef.update({
        'lastMessage': '$imageUrl', // Use the direct image URL in lastMessage
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadMessages': 1
      });

      // Clear the message input field
      messageController.text = '';
    });
  }

  String getFileTypeFromExtension(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return 'image';
      default:
        return 'file';
    }
  }

  void sendMessageWithFile(File file) async {
    // Get the chat document reference
    final chatRef = FirebaseFirestore.instance
        .collection('chatNutritionist')
        .doc(chatDocId);

    // Upload the file to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(
        'files/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}');
    final uploadTask = storageRef.putFile(file);
    final storageSnapshot = await uploadTask.whenComplete(() => null);
    final fileUrl = await storageSnapshot.ref.getDownloadURL();

    // Determine the file type display name
    // final fileTypeDisplayName =
    //     getFileTypeDisplayName(file.path.split('.').last);

    // Add the file message to the messages collection in the chat document
    chatRef.collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'msg': fileUrl, // Store the file URL
      'type': file.path.split('.').last, // Store the file extension
    }).then((value) {
      // Update the lastMessage and lastMessageTime fields in the chat document
      chatRef.update({
        'lastMessage': fileUrl, // Use the file URL in lastMessage
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadMessages': 1
      });

      // Clear the message input field
      messageController.text = '';
    });
  }

  String getFileTypeDisplayName(String fileExtension) {
    switch (fileExtension) {
      case 'pdf':
        return 'PDF';
      case 'doc':
      case 'docx':
        return 'Word Document';
      case 'xls':
      case 'xlsx':
        return 'Excel Spreadsheet';
      case 'txt':
        return 'Text File';
      default:
        return 'File';
    }
  }

  void moreInfo() async {
    final nutritionistSnapshot = await FirebaseFirestore.instance
        .collection('Nutritionist')
        .where('nid', isEqualTo: friendUid)
        .limit(1)
        .get();
    if (nutritionistSnapshot.docs.isNotEmpty) {
      final nutritionistData = nutritionistSnapshot.docs.first.data();
      final username = nutritionistData['username'];
      final fullname = nutritionistData['fullname'];
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
      if (gender == '1') {
        gender = 'Male';
      } else if (gender == '2') {
        gender = 'Female';
      } else if (gender == '3') {
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
                  Text('Username: Dr $username'),
                  Text(''),
                  Text('fullname: $fullname'),
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
