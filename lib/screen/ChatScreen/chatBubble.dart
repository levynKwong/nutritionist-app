import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
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
    print('$message');
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
                                  deleteFile(message);
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
                      } else if (fileType == 'image') {
                        await launch(message);
                      }
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

  void deleteFile(String url) async {
    try {
      // Get a reference to the file in Firebase Storage
      Reference fileRef = FirebaseStorage.instance.refFromURL(url);

      // Delete the file
      await fileRef.delete();

      // Print a success message
      print('File deleted successfully');
    } catch (e) {
      // Print an error message
      print('Error deleting file: $e');
    }
  }
}
