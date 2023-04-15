// Positioned(
//                           bottom: 0,
//                           left: (MediaQuery.of(context).size.width / 2) - 45,
//                           child: GestureDetector(
//                             onTap: () {
//                               if (_isChecked == true) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => DoctorForum(),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     spreadRadius: 2,
//                                     blurRadius: 5,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(50.0),
//                                 child: Icon(
//                                   Icons.chevron_right,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),