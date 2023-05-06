import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeAvailabilityScreen extends StatefulWidget {
  final String userId;
  final String nutritionistId;

  TimeAvailabilityScreen({required this.userId, required this.nutritionistId});

  @override
  _TimeAvailabilityScreenState createState() => _TimeAvailabilityScreenState();
}

class _TimeAvailabilityScreenState extends State<TimeAvailabilityScreen> {
  late Stream<List<bool>> _timeAvailabilityStream;
  List<bool> _selectedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _timeAvailabilityStream = FirebaseFirestore.instance
        .collection('timeAvailability')
        .doc(widget.nutritionistId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null && data['timesAvailable'] != null) {
        return List<bool>.from(data['timesAvailable']);
      } else {
        return <bool>[];
      }
    });
    _selectedTimeSlots = List<bool>.filled(0, false);
  }

  void _toggleSelection(int index) {
    setState(() {
      _selectedTimeSlots[index] = !_selectedTimeSlots[index];
    });
  }

  List<int> _getAvailableTimeSlots(List<bool> timeAvailable) {
    final availableTimeSlots = <int>[];
    for (int i = 0; i < timeAvailable.length; i++) {
      if (timeAvailable[i]) {
        availableTimeSlots.add(i);
      }
    }
    return availableTimeSlots;
  }

  void _confirmSelection(List<bool> timeAvailable) async {
    final selectedTimeSlots = <int>[];
    for (int i = 0; i < _selectedTimeSlots.length; i++) {
      if (_selectedTimeSlots[i]) {
        selectedTimeSlots.add(i);
      }
    }

    if (selectedTimeSlots.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();

      final timeSlotsRef = FirebaseFirestore.instance.collection('timeSlots');

      for (final selectedTimeSlot in selectedTimeSlots) {
        final index = _getAvailableTimeSlots(timeAvailable)[selectedTimeSlot];

        batch.set(
          timeSlotsRef.doc(),
          {
            'userId': widget.userId,
            'nutritionistId': widget.nutritionistId,
            'timeSlot': 'Time ${index + 1}',
          },
        );

        timeAvailable[index] = false;
      }

      batch.update(
        FirebaseFirestore.instance
            .collection('timeAvailability')
            .doc(widget.nutritionistId),
        {'timesAvailable': timeAvailable},
      );

      await batch.commit();

      setState(() {
        _selectedTimeSlots = List<bool>.filled(timeAvailable.length, false);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Selection confirmed!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select at least one time slot!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<List<bool>>(
          stream: _timeAvailabilityStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final timeAvailable = snapshot.data!;
            if (_selectedTimeSlots.length != timeAvailable.length) {
              _selectedTimeSlots =
                  List<bool>.filled(timeAvailable.length, false);
            }
            if (timeAvailable.isEmpty) {
              return Text('No time slots available');
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Wrap(
                      runSpacing: 8.0, // set space between rows
                      children: List.generate(
                        _getAvailableTimeSlots(timeAvailable).length,
                        (index) {
                          final isSelected = _selectedTimeSlots[index];
                          final availableIndex =
                              _getAvailableTimeSlots(timeAvailable)[index];
                          final timeSlot = 'Time ${availableIndex + 1}';
                          return SizedBox(
                            width: 100, // set width of button
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _toggleSelection(index);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) {
                                      if (isSelected) {
                                        return Colors.red;
                                      } else {
                                        return Colors.grey;
                                      }
                                    },
                                  ),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 30)),
                                ),
                                child: Text(
                                  timeSlot,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _confirmSelection(timeAvailable);
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
