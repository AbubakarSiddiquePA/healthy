import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy/reminders/add_rmndr.dart';
import 'package:healthy/reminders/dlt_remndr.dart';
import 'package:healthy/reminders/services/ntfction_logic.dart';
import 'package:healthy/reminders/switcher.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  User? user;
  bool on = true;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    NotificationLogic.init(context, user!.uid);
    listenNotification();
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Reminders",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () async {
            addReminder(context, user!.uid);
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: Colors.accents,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 2, offset: Offset(0, 2))
                ]),
            child: const Center(
                child: Icon(
              Icons.add,
              size: 30,
            )),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .collection("reminder")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Nothing to show"),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data?.docs.length,
              itemBuilder: (context, index) {
                Timestamp t = data?.docs[index].get("time");
                DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                    t.microsecondsSinceEpoch);
                String formattedTime = DateFormat.jm().format(date);
                on = data!.docs[index].get("onOff");
                if (on) {
                  NotificationLogic.showNotifications(
                      dateTime: date,
                      id: 0,
                      title: "Reminder Title",
                      body: "donnot forget to drink water");
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              formattedTime,
                              style: const TextStyle(fontSize: 30),
                            ),
                            subtitle: const Text("Everyday"),
                            trailing: SizedBox(
                              width: 110,
                              child: Row(
                                children: [
                                  Switcher(on, user!.uid, data.docs[index].id,
                                      data.docs[index].get("time")),
                                  IconButton(
                                      onPressed: () {
                                        deleteReminder(context,
                                            data.docs[index].id, user!.uid);
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.circleXmark))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
