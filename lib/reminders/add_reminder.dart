import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();

  // Time selection state management
  DateTime? _selectedTime;
  List<bool> _selectedWeekdays =
      List.filled(7, false); // Initialize all days to false

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reminder"),
        actions: [
          TextButton(
            onPressed: () {
              // Validate form and handle reminder creation logic
              if (_formKey.currentState!.validate()) {
                // Implement logic to save reminder with time and weekdays
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reminder created!'),
                  ),
                );
                // Clear form fields after successful creation
                _titleController.clear();
                _reminderController.clear();
                _selectedTime = null;
                _selectedWeekdays = List.filled(7, false);
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
                const Row(
                  children: [
                    Text("Reminder Title"),
                  ],
                ),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text("Reminder Message "),
                  ],
                ),
                TextFormField(
                  controller: _reminderController,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Time selection button
                TextButton(
                  onPressed: () {
                    DatePicker.showTimePicker(
                      context,
                      showSecondsColumn: true,

                      // onDateSelected: (date) {
                      //   setState(() {
                      //     _selectedTime = date;
                      //   });
                      // },
                    );
                  },
                  child: const Row(
                    children: [
                      Text("Select Time: "),
                      // Text(_selectedTime?.format(context) ?? 'No time selected'), // Display selected time or default message
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Repeat on Weekdays: "),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  // Wrap for better layout on small screens
                  children:
                      List.generate(7, (index) => _buildWeekdayCheckbox(index)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build weekday checkbox
  Widget _buildWeekdayCheckbox(int weekdayIndex) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return CheckboxListTile(
      title: Text(weekdays[weekdayIndex]),
      value: _selectedWeekdays[weekdayIndex],
      onChanged: (bool? value) {
        setState(() {
          _selectedWeekdays[weekdayIndex] = value!;
        });
      },
    );
  }
}
