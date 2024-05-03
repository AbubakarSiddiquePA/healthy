import 'package:flutter/material.dart';
import 'package:healthy/modelclasshabit/addhabit_model.dart';
import 'package:healthy/reminders/reminders.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
  }

  void _saveHabit() {
    Habit newHabit = Habit(
        name: _nameController.text,
        motivation: _motivationController.text,
        daysPerWeek: _daysPerWeek,
        startDate: _startDate);
    Navigator.pop(context, newHabit);
  }

  // final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  int _daysPerWeek = 1;
  DateTime _startDate = DateTime.now();
  // bool _reminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _saveHabit,
            child: const Text("Save"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: Form(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: [
                    Text("Name"),
                  ],
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter a name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text("Motivate yourself "),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
                TextFormField(
                  controller: _motivationController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "How many days per week you should complete the habit"),
                Row(
                  children: [
                    DropdownButton<int>(
                      value: _daysPerWeek,
                      onChanged: (value) {
                        setState(() {
                          _daysPerWeek =
                              value!; // Assign the new value to _daysPerWeek
                        });
                      },
                      items: List.generate(
                        7,
                        (index) {
                          return DropdownMenuItem(
                              value: index + 1, child: Text("${index + 1}"));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Start Date"),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != _startDate) {
                          setState(() {
                            _startDate = picked;
                          });
                        }
                      },
                      child: Text(
                          "Selected Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReminderPage(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color.fromARGB(255, 202, 199, 199),
                            )),
                        width: 150,
                        height: 40,
                        child: const Center(
                            child: Text(
                          ' 🔔Reminders',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
