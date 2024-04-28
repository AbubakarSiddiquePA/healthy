import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  int _daysPerWeek = 1;
  DateTime _startDate = DateTime.now();
  bool _reminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
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
                          _daysPerWeek != value;
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
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != _startDate) {
                          setState(() {
                            _startDate = picked;
                          });
                        }
                      },
                      child: const Text("Select Date"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
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
