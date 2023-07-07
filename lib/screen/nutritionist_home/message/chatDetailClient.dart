import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_aware/screen/auth/SaveUser.dart';
import 'package:meal_aware/screen/customer_widget.dart/clientAdditionalDay.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/menuFormNutritionist.dart';
import 'package:meal_aware/screen/customer_widget.dart/reportButton.dart';
import 'package:meal_aware/screen/nutritionist_home/moreInfo.dart';
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
  bool sendButtonEnabled = true;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  bool isTextFieldInFocus = false;
  var chatDocId;
  _ChatDetailClientState(this.friendUid, this.friendName);
  File? selectedImage;

  String? imageUrl;
  File? selectedFile;
  @override
  void initState() {
    super.initState();
    _getChatDocId();
    changeUnreadMessage();
    checkStatus();
    getImageLink().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  Future<String> getImageLink() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(friendUid)
        .get();

    if (docSnapshot.exists) {
      final image_url = docSnapshot.get('image_url');
      return image_url != null ? image_url : 'image_url';
    } else {
      return 'image_url';
    }
  }

  void _toggleButton(bool enabled) {
    setState(() {
      sendButtonEnabled = enabled;
    });
  }

  void checkStatus() {
    FirebaseFirestore.instance
        .collection('payments')
        .where('pid', isEqualTo: friendUid)
        .where('nid', isEqualTo: currentId)
        .where('status', isEqualTo: 1)
        .limit(1)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _toggleButton(false);
      } else {
        _toggleButton(true);
      }
    }, onError: (error) {
      // Handle error during status check
      print('Error checking status: $error');
    });
  }

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

      await chats.doc(docId).update({'readP': true});
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
                automaticallyImplyLeading: true,
                title: Row(
                  children: [
                   
                    Expanded(
                      // Wrap Text widget with Expanded
                      child: Text(
                        '${widget.friendName}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary
                          // Add any other desired text styles
                        ), // Set overflow property
                      ),
                    ),
                  ],
                ),
                backgroundColor: getColor(context),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: height_ * 0.01, top: height_ * 0.01),
                    child: Container(
                      height: height_ * 0.05,
                      width: width_ * 0.15,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(231, 139, 139, 139),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return moreinfo(friendId: friendUid);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  ReportButton(
                    userId: friendUid,
                    friendId: currentId,
                  ),
                  MenuButtonNutritionist(
                    userId: friendUid,
                    friendId: currentId,
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
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (sendButtonEnabled) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirmation'),
                                              content: Text(
                                                  'Give them additional 1 day?\nAmount will be displayed 0'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Perform the desired action here
                                                    clientAdditionalDay(
                                                        context, friendUid);
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red),
                                                  ),
                                                  child: Text('Confirm'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Cancel the action
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.grey),
                                                  ),
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                       
                                      ),
                                      child: Icon(
                                        Icons.circle,
                                        color: sendButtonEnabled
                                            ? Colors.red
                                            : Colors.green,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: getColor(context),
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
        'readN': false
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
        'readN': false
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
        
        'readN': false
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
}
