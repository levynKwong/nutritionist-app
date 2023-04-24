import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.userId, required this.userName})
      : super(key: key);

  final String userId;
  final String userName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=3'),
              ),
              SizedBox(width: width_ * 0.03),
              Text('${widget.userName}'),
            ],
          ),
          backgroundColor: Color(0xFF989efd),
          actions: [
            IconButton(
              icon: Icon(Icons.report),
              onPressed: () {
                // handle report button press here
              },
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
                    // itemCount: widget.chat.orderedMessages.length,
                    itemBuilder: ((context, index) {
                      String time =
                          new DateTime.fromMillisecondsSinceEpoch(int.tryParse(
                              // widget.chat.orderedMessages[index].time ??
                              "0") ?? 0).toString();
                      String formatedTime = time.substring(11, 16);

                      // if (widget.chat.orderedMessages[index].isOwnerSent) {
                      //   return OwnMessageCard(
                      //       message: widget.chat.orderedMessages[index].content,
                      //       time: formatedTime);
                      // } else {
                      //   return OthersMessageCard(
                      //       message: widget.chat.orderedMessages[index].content,
                      //       time: formatedTime);
                      // }
                    }),
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
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: TextFormField(
                          // controller: messageController,
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
                    backgroundColor: Color(0xFF575dcb),
                    radius: 22.5,
                    child: IconButton(
                      onPressed: () {
                        // if (messageController.text != "") {
                        //   sendMessage(messageController.text);

                        //   setState(() {});
                        //   messageController.clear();
                        // }
                      },
                      icon: const Icon(Icons.send_rounded),
                      color: Colors.white,
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
