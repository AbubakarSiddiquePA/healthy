import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/reminders/rmndrmodel.dart';

class Switcher extends StatefulWidget {
  bool onOff;
  String uid;
  Timestamp timestamp;
  String id;

  Switcher(this.onOff, this.uid, this.timestamp, this.id);
  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.onOff,
      onChanged: (bool value) {
        ReminderModel reminderModel = ReminderModel();
        reminderModel.onOff = value;
        reminderModel.timestamp = widget.timestamp;
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.uid)
            .collection("reminder")
            .doc(widget.id)
            .update(reminderModel.toMap());
      },
    );
  }
}
