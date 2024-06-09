import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy/reminders/reminders_add.dart';
import 'package:healthy/reminders/reminders_delete.dart';
import 'package:healthy/reminders/services/reminders_notification_logic.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      NotificationLogic.init(context, user!.uid);
      listenNotification();
    }
  }

  void listenNotification() {
    NotificationLogic.onNotifications.listen((value) {});
  }

  void onClickedNotifications(String? payLoad) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ReminderPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Container(),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Reminders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () async {
          if (user != null) {
            await addReminder(context, user!.uid);
            setState(() {});
          }
        },
        child: const Center(
            child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        )),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .collection("reminder")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data?.docs ?? [];
                if (data.isEmpty) {
                  return const Center(
                    child: Text("No reminders found."),
                  );
                }

                return ListView.builder(
                  itemCount: data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(""),
                      );
                    }

                    final reminderData =
                        data[index - 1].data() as Map<String, dynamic>;
                    final formattedTime =
                        DateFormat.jm().format(reminderData['time'].toDate());
                    final message = reminderData['message'] ?? 'No message';

                    DateTime dateTime = reminderData['time'].toDate();
                    NotificationLogic.showNotifications(
                      dateTime: dateTime,
                      id: data[index - 1].id.hashCode,
                      title: "Reminder",
                      body: "Reminder at $formattedTime - $message",
                    );

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('🔔 $formattedTime'),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.limeAccent[400],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(message),
                              )),
                        ),
                        // trailing: deleteReminder(context, id, uid)
                        trailing: CircleAvatar(
                          backgroundColor: Colors.limeAccent[400],
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteReminder(
                                  context, data[index - 1].id, user!.uid);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
