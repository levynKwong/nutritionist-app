import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';
import 'package:meal_aware/screen/customer_widget.dart/notification_service.dart';

class ReportButton extends StatefulWidget {
  final String userId;
  final String friendId;

  ReportButton({required this.userId, required this.friendId});

  @override
  _ReportButtonState createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  String _reason = '';
  bool _anonymous = false;
  final _formKey = GlobalKey<FormState>();
  bool _buttonsPressed = false; // Track if the buttons have been pressed

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Report User'),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RadioListTile<String>(
                            title: const Text('Inappropriate behavior'),
                            value: 'Inappropriate behavior',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Spam or fraud'),
                            value: 'Spam or fraud',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Unprofessional conduct'),
                            value: 'Unprofessional conduct',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Providing inaccurate information'),
                            value: 'Providing inaccurate information',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Unresponsive or unhelpful communication'),
                            value: 'Unresponsive or unhelpful communication',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Report anonymously'),
                            value: _anonymous,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _anonymous = value!;
                                  _buttonsPressed = true; // Mark buttons as pressed
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: getColor(context),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Report'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: getColor(context),
                        ),
                      ),
                      onPressed: _buttonsPressed // Only allow pressing if buttons are pressed
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final reportData = {
                                  'userId': widget.userId,
                                  'nutritionistId': widget.friendId,
                                  'reason': _reason,
                                  'anonymous': _anonymous,
                                  'timestamp': FieldValue.serverTimestamp(),
                                };
                                FirebaseFirestore.instance
                                    .collection('Report')
                                    .add(reportData)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Report submitted successfully!\nPlease expect an email from us, our team will review your report and take action accordingly',
                                      ),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                  NotificationService.showNotification(
                                    title: 'User Reported',
                                    body:
                                        'You have reported a user for $_reason. Thank you for your feedback!',
                                  );
                                }).catchError((error) {
                                  print('Error adding report: $error');
                                });
                              }
                            }
                          : null, // Disable the button if buttons are not pressed
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Icon(Icons.report, color: Theme.of(context).colorScheme.secondary),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}