import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:healthy/providers/reminderprovider/reminder_provider.dart';
import 'package:provider/provider.dart';
import 'package:healthy/models/reminder_model.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReminderProvider(),
      child: const AddReminderForm(),
    );
  }
}

class AddReminderForm extends StatefulWidget {
  const AddReminderForm({super.key});

  @override
  State<AddReminderForm> createState() => _AddReminderFormState();
}

class _AddReminderFormState extends State<AddReminderForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final reminderProvider =
        Provider.of<ReminderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reminder"),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  reminderProvider.validateTime() &&
                  reminderProvider.validateWeekdays()) {
                final newReminder = Reminder(
                  title: reminderProvider.titleController.text,
                  message: reminderProvider.reminderController.text,
                  time: reminderProvider.selectedTime!,
                  weekdays: reminderProvider.selectedWeekdays,
                  id: '',
                );
                Navigator.pop(context, newReminder);

                reminderProvider.reset();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, child) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: "Reminder Name",
                        labelStyle: const TextStyle(),
                        suffixIcon: const Icon(Icons.title),
                        suffixIconColor: Colors.limeAccent[400],
                        hintText: "Set Reminder Name",
                        border: const OutlineInputBorder(),
                      ),
                      controller: reminderProvider.titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, child) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: "Reminder Message",
                        labelStyle: const TextStyle(),
                        suffixIcon: const Icon(Icons.message),
                        suffixIconColor: Colors.limeAccent[400],
                        hintText: "Set Reminder Message",
                        border: const OutlineInputBorder(),
                      ),
                      controller: reminderProvider.reminderController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a message";
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, child) {
                    return TextButton(
                      onPressed: () {
                        DatePicker.showTimePicker(
                          context,
                          showSecondsColumn: false,
                          onConfirm: (date) {
                            reminderProvider.setSelectedTime(date);
                          },
                        );
                      },
                      child: Row(
                        children: [
                          const Text("Select Time: "),
                          Text(reminderProvider.getFormattedTime()),
                        ],
                      ),
                    );
                  },
                ),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, child) {
                    if (!reminderProvider.validateTime()) {
                      return const Text(
                        "Please select a time",
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                const Text("Repeat on Weekdays: "),
                const SizedBox(height: 10),
                Wrap(
                  children: List.generate(
                    7,
                    (index) => _buildWeekdayCheckbox(context, index),
                  ),
                ),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, child) {
                    if (!reminderProvider.validateWeekdays()) {
                      return const Text(
                        "Please select at least one weekday",
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekdayCheckbox(BuildContext context, int weekdayIndex) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Consumer<ReminderProvider>(
      builder: (context, provider, child) {
        return CheckboxListTile(
          title: Text(weekdays[weekdayIndex]),
          value: provider.selectedWeekdays[weekdayIndex],
          onChanged: (bool? value) {
            provider.toggleWeekday(weekdayIndex, value!);
          },
        );
      },
    );
  }
}
