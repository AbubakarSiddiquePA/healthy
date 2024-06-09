// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy/reminders/reminders_model.dart';
import 'package:healthy/reminders/services/reminders_notification_logic.dart';

Future<void> addReminder(BuildContext context, String uid) async {
  TimeOfDay time = TimeOfDay.now();
  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> add(String uid, TimeOfDay time, String message) async {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime =
          DateTime(d.year, d.month, d.day, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      ReminderModel reminderModel = ReminderModel();
      reminderModel.timestamp = timestamp;
      reminderModel.message = message;

      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("reminder")
          .add(reminderModel.toMap());

      Fluttertoast.showToast(msg: "Reminder Added");

      NotificationLogic.showNotifications(
        id: docRef.id.hashCode,
        title: "Reminder",
        body: " ${time.format(context)} - $message",
        dateTime: dateTime,
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  await showDialog(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Select a Time for Reminder"),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (newTime == null) return;
                          setState(() {
                            time = newTime;
                          });
                        },
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.clock,
                              color: Colors.green,
                              size: 40,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              time.format(context).toString(),
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 30),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: messageController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          labelText: "Enter your message",
                          hintText: "Please enter your reminder message",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a message";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: loading
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              String message = messageController.text;
                              setState(() {
                                loading = true;
                              });
                              await add(uid, time, message);
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please enter message before you set reminder");
                            }
                          },
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Add")),
              ],
            );
          },
        );
      });
}
