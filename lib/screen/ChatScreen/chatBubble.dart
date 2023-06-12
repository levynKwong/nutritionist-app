import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final String friendUid;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.friendUid,
  }) : super(key: key);

  String getFileTypeFromUrl(String url) {
    if (url.toLowerCase().contains('.jpg') ||
        url.toLowerCase().contains('.jpeg') ||
        url.toLowerCase().contains('.png') ||
        url.toLowerCase().contains('.gif')) {
      return 'image';
    } else {
      return 'file';
    }
  }

  @override
  Widget build(BuildContext context) {
    String fileType = getFileTypeFromUrl(message);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: isMe ? Color(0xFF575dcb) : Color(0xFFE0E0E0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
              ),
            ),
            child: message.startsWith('http')
                ? GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete $fileType?'),
                            content: Text(
                                'Are you sure you want to delete this $fileType?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  // Call a function to delete the image or file
                                  deleteFile(message, context);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onTap: () async {
                      if (fileType == 'file') {
                        if (await canLaunch(message)) {
                          await launch(message);
                        } else {
                          print('Could not launch $message');
                        }
                        await launch(message);
                      } else if (fileType == 'image') {}
                    },
                    child: fileType == 'image'
                        ? Image.network(
                            message,
                            // Add any necessary properties like width, height, etc.
                          )
                        : ListTile(
                            leading: Icon(Icons.insert_drive_file),
                            title: Text(
                              'File',
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                  )
                : Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
          ),
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void deleteFile(String message, context) async {
    try {
      // Delete the file from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(message);
      await storageRef.delete();

      // Delete the message from Cloud Firestore
      final firestoreRef =
          FirebaseFirestore.instance.collection('chatNutritionist');
      final querySnapshot = await firestoreRef.get();

      // Iterate through chat documents
      for (final chatDoc in querySnapshot.docs) {
        final messagesRef = chatDoc.reference.collection('messages');
        final querySnapshot =
            await messagesRef.where('msg', isEqualTo: message).get();

        // Check if any matching message document is found
        if (querySnapshot.docs.isNotEmpty) {
          // Get the reference to the first matching message document
          final messageDocRef = querySnapshot.docs.first.reference;

          // Delete the message document
          await messageDocRef.delete();

          // Print a success message

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Message document deleted successfully"),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        }
      }

      // Print a success message if the message document was not found

      // Print a success message
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting file and message: $e"),
          backgroundColor: Color.fromARGB(255, 159, 1, 1),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

     