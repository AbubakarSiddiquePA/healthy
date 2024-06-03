import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy/reminders/rmndrmodel.dart';

addReminder(BuildContext context, String uid) {
  TimeOfDay time = TimeOfDay.now();
  add(String uid, TimeOfDay time) {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime =
          DateTime(d.year, d.month, d.day, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      ReminderModel reminderModel = ReminderModel();
      reminderModel.timestamp = timestamp;
      reminderModel.onOff = false;
      FirebaseFirestore.instance
          .collection("users")
          .doc("uid")
          .collection("reminder")
          .doc()
          .set(reminderModel.toMap());
      Fluttertoast.showToast(msg: "Reminder Added");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Text("Add Reminder"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Select a Time for Reminder"),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (newTime == null) return;
                      setState(
                        () {
                          time = newTime;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.green,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          time.format(context).toString(),
                          style: const TextStyle(
                              color: Colors.green, fontSize: 30),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    add(uid, time);
                    Navigator.pop(context);
                  },
                  child: const Text("Add")),
            ],
          );
        },
      );
    },
  );
}
