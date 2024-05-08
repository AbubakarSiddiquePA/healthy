import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/modelclasshabit/addhabit_model.dart';
import 'package:healthy/reminders/reminders.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  int _daysPerWeek = 1;
  DateTime _startDate = DateTime.now();

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      Habit newHabit = Habit(
        id: "",
        name: _nameController.text,
        motivation: _motivationController.text,
        daysPerWeek: _daysPerWeek,
        startDate: _startDate,
      );
      FirebaseFirestore.instance
          .collection("habitsCollection")
          .add(newHabit.toMap());

      Navigator.pop(context, newHabit);
    }
  }

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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Habit Name",
                ),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Motivate yourself "),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: _motivationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a motivation";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "How many days per week you should complete the habit"),
                DropdownButton<int>(
                  value: _daysPerWeek,
                  onChanged: (value) {
                    setState(() {
                      _daysPerWeek = value!;
                    });
                  },
                  items: List.generate(
                    7,
                    (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text("${index + 1}"),
                      );
                    },
                  ),
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
                        "Selected Date: ${DateFormat('yyyy-MMM-dd').format(_startDate)}",
                      ),
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
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 202, 199, 199),
                          ),
                        ),
                        width: 150,
                        height: 40,
                        child: const Center(
                          child: Text(
                            ' 🔔Reminders',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
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
