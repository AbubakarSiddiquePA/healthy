import 'package:flutter/material.dart';
import 'package:healthy/reminders/add_reminder.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddReminder(),
                  ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // body: ,
    );
  }
}
