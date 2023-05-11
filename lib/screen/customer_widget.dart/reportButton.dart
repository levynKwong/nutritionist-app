
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_aware/screen/customer_widget.dart/color.dart';

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
  String _text = '';
  final _formKey = GlobalKey<FormState>();

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
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title:
                                const Text('Providing inaccurate information'),
                            value: 'Providing inaccurate information',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
                                });
                              }
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text(
                                'Unresponsive or unhelpful communication'),
                            value: 'Unresponsive or unhelpful communication',
                            groupValue: _reason,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  _reason = value!;
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
                          color: getColor(),
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
                          color: getColor(),
                        ),
                      ),
                      onPressed: () {
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
                                    'Report submitted successfully!\n\Please expect an email from us, our team will review your report and take action accordingly'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }).catchError((error) {
                            print('Error adding report: $error');
                          });
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Icon(Icons.report),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
