import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/reminders/add_rmndr.dart';
import 'package:healthy/reminders/services/ntfction_logic.dart';

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
    // TODO: implement initState
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
          builder: (context) => ReminderPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Reminders",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            onPressed: () async {
              addReminder(context, user!.uid);
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Colors.accents,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(0, 2))
                  ]),
              child: Center(
                  child: Icon(
                Icons.add,
                size: 30,
              )),
            ),
          ),
        ));
  }
}
