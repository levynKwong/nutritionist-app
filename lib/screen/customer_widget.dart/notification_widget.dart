// import 'package:flutter/material.dart';

// class NotificationWidget extends StatefulWidget {
//   const NotificationWidget({Key? key, this.onNewNotification})
//       : super(key: key);

//   final Function(String)? onNewNotification;

//   @override
//   _NotificationWidgetState createState() => _NotificationWidgetState();
// }

// class _NotificationWidgetState extends State<NotificationWidget> {
//   List<String> notifications = [];
//   bool hasNewNotifications = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         IconButton(
//           icon: Icon(Icons.notifications),
//           onPressed: () {
//             setState(() {
//               showNotificationDialog();
//               hasNewNotifications = false;
//             });
//           },
//         ),
//         if (hasNewNotifications)
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               constraints: BoxConstraints(
//                 minWidth: 16,
//                 minHeight: 16,
//               ),
//               child: Text(
//                 notifications.length.toString(),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//         if (notifications.isNotEmpty) buildNotificationDialog(),
//       ],
//     );
//   }

//   Widget buildNotificationDialog() {
//     return AlertDialog(
//       title: Text('Recent Notifications'),
//       content: Container(
//         width: double.maxFinite,
//         constraints: BoxConstraints(maxHeight: 200),
//         child: ListView.builder(
//           itemCount: notifications.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(notifications[index]),
//             );
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             setState(() {
//               notifications.clear();
//               hasNewNotifications = false;
//             });
//             Navigator.pop(context);
//           },
//           child: Text('Close'),
//         ),
//       ],
//     );
//   }

//   void showNotificationDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Recent Notifications'),
//           content: Container(
//             width: double.maxFinite,
//             constraints: BoxConstraints(maxHeight: 200),
//             child: ListView.builder(
//               itemCount: notifications.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(notifications[index]),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   notifications.clear();
//                   hasNewNotifications = false;
//                 });
//                 Navigator.pop(context);
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void handleNewNotification(String notificationContent) {
//     addNotification(notificationContent);
//   }

//   void addNotification(String notification) {
//     setState(() {
//       if (notifications.length >= 5) {
//         notifications.removeAt(0);
//       }
//       notifications.add(notification);
//       hasNewNotifications = true;
//     });
//   }
// }
