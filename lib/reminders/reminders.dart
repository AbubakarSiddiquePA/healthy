import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:healthy/reminders/add_reminder.dart';
import 'package:healthy/providers/reminderprovider/reminder_provider.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReminderProvider()..fetchReminders(),
      child: Consumer<ReminderProvider>(
        builder: (context, reminderProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Reminders"),
              actions: [
                IconButton(
                  onPressed: () async {
                    final newReminder = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddReminder(),
                      ),
                    );
                    if (newReminder != null) {
                      await reminderProvider.addReminder(newReminder);
                      await reminderProvider
                          .fetchReminders(); // Fetch the reminders again after adding a new one
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: reminderProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : reminderProvider.reminders.isEmpty
                    ? const Center(child: Text('No reminders added'))
                    : ListView.builder(
                        itemCount: reminderProvider.reminders.length,
                        itemBuilder: (context, index) {
                          final reminder = reminderProvider.reminders[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Colors.limeAccent[400],
                              child: ListTile(
                                title: Text(reminder.title),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Message: ${reminder.message}'),
                                    const SizedBox(height: 10),
                                    Text(
                                        'Time: ${DateFormat('jm').format(reminder.time)}'),
                                    const SizedBox(height: 10),
                                    Text('Weekdays: ${reminder.weekdays}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await reminderProvider
                                        .deleteReminder(reminder.id);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
