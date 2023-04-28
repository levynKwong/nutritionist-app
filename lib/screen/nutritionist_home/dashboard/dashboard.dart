import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:table_calendar/table_calendar.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          appBar(width_),
          SizedBox(
            height: height_ * 0.0,
          ),
          info(width_, height_),
          SizedBox(
            height: height_ * 0.0,
          ),
          client(width_, height_),
        ],
      ),
    );
  }

  Widget client(double width_, double height_) {
    return SizedBox(
      height: height_ * 0.59,
      width: width_ * 1.3,
      child: Container(
        margin: EdgeInsets.all(width_ * 0.04),
        padding: EdgeInsets.all(width_ * 0.03),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 207, 207, 207),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        // child: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height_ * 0.0,
            ),
            Row(
              children: [
                SizedBox(width: width_ * 0.03),
                // margin: EdgeInsets.only(right: width_ * 0.065),
                Text(
                  'Pending Plan',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: width_ * 0.054,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width_ * 0.03,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: double.minPositive),
                          Text(
                            'Plan Type',
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                              fontSize: width_ * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: width_ * 0.1,
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              print('Add plan');
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: width_ * 0.15,
                            height: height_ * 0.023,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 184, 184, 184),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width_ * 0.03),
                                  child: Text(
                                    'Text',
                                    style: TextStyle(fontSize: width_ * 0.035),
                                  ),
                                ),
                                Container(
                                  width: width_ * 0.032,
                                  height: height_ * 0.032,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: width_ * 0.003,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width_ * 0.01,
                          ),
                          Container(
                            width: width_ * 0.27,
                            height: height_ * 0.023,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 184, 184, 184),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: width_ * 0.008),
                                  child: Text(
                                    'Appointment',
                                    style: TextStyle(fontSize: width_ * 0.035),
                                  ),
                                ),
                                Container(
                                  width: width_ * 0.032,
                                  height: height_ * 0.032,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: width_ * 0.006,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height_ * 0.01,
            ),
            Container(
              margin: EdgeInsets.only(left: width_ * 0.05),
              child: Row(
                children: [
                  SizedBox(width: width_ * 0.03),
                  Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: width_ * 0.21),
                  Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: width_ * 0.04),
                  Text(
                    'Due Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: width_ * 0.035),
                  Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height_ * 0.01,
            ),
            Container(
              height: height_ * 0.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: width_ * 0.0025,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              height: height_ * 0.36,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(fontSize: width_ * 0.06),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(fontSize: width_ * 0.06),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // );
  }

  Widget info(double width_, double height_) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width_ * 0.04,
              ),
              MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                  minWidth: width_ * 0.40,
                  height: height_ * 0.10,
                  child: Row(
                    children: [
                      Container(
                        width: width_ * 0.07, // set desired width of image
                        height: height_ * 0.035, // set desired height of image
                        child: Image.asset(
                          'images/appointment.png', // path to local image file
                          fit: BoxFit
                              .cover, // specify how the image should be resized to fit into the available space
                        ),
                      ),
                      SizedBox(
                        width: width_ * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'Text Message',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total: 28',
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                              fontSize: width_ * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: width_ * 0.03,
              ),
              MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                  minWidth: width_ * 0.44,
                  height: height_ * 0.10,
                  child: Row(
                    children: [
                      Container(
                        width: width_ * 0.07, // set desired width of image
                        height: height_ * 0.03, // set desired height of image
                        child: Image.asset(
                          'images/add-group.png', // path to local image file
                          fit: BoxFit
                              .cover, // specify how the image should be resized to fit into the available space
                        ),
                      ),
                      SizedBox(
                        width: width_ * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'New Client',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'This month',
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                              fontSize: width_ * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: width_ * 0.04,
              ),
            ],
          ),
          SizedBox(
            height: height_ * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: width_ * 0.04,
              ),
              MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                  minWidth: width_ * 0.44,
                  height: height_ * 0.10,
                  child: Row(
                    children: [
                      Container(
                        width: width_ * 0.07, // set desired width of image
                        height: height_ * 0.035, // set desired height of image
                        child: Image.asset(
                          'images/file.png', // path to local image file
                          fit: BoxFit
                              .cover, // specify how the image should be resized to fit into the available space
                        ),
                      ),
                      SizedBox(
                        width: width_ * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'Text Message',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total: 28',
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                              fontSize: width_ * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: width_ * 0.03,
              ),
              MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                  minWidth: width_ * 0.44,
                  height: height_ * 0.10,
                  child: Row(
                    children: [
                      Container(
                        width: width_ * 0.07, // set desired width of image
                        height: height_ * 0.03, // set desired height of image
                        child: Image.asset(
                          'images/customer.png', // path to local image file
                          fit: BoxFit
                              .cover, // specify how the image should be resized to fit into the available space
                        ),
                      ),
                      SizedBox(
                        width: width_ * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            'Client Counter',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: width_ * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'left ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                              fontSize: width_ * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: width_ * 0.04,
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar(double width_) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.black,
          fontSize: width_ * 0.07,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
          onPressed: () {
            popUpButton(context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            // Add your code here for notification icon action
          },
        ),
      ],
    );
  }

  Future<dynamic> popUpButton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 400,
            width: 300,
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              // Add any additional calendar properties here
            ),
          ),
        );
      },
    );
  }
}
