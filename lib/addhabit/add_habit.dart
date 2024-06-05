import 'package:flutter/material.dart';
import 'package:healthy/const/homestyle.dart';
import 'package:healthy/providers/authprovider/habitprovider/addhabitprovider.dart';
import 'package:healthy/reminders/rmndr_home.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  List<int> selectedDays = [];
  DateTime startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddHabitProvider>(builder: (context, addhabitprovider, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                if (addhabitprovider.habitNameController.text.isEmpty ||
                    addhabitprovider.motivationNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please fill all the fields",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  Provider.of<AddHabitProvider>(context, listen: false)
                      .saveHabit(context);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.limeAccent[400]),
              ),
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
                  TextFormField(
                    controller: addhabitprovider.habitNameController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: "Habit Name",
                      labelStyle: const TextStyle(),
                      suffixIcon: const Icon(Icons.favorite),
                      suffixIconColor: Colors.limeAccent[400],
                      hintText: "Eg:- Go to Gym",
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => addhabitprovider.setHabitName(value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addhabitprovider.motivationNameController,
                    decoration: InputDecoration(
                      labelText: "Motivate yourself",
                      suffixIcon: const Icon(Icons.sports_gymnastics),
                      suffixIconColor: Colors.limeAccent[400],
                      hintText: "Write something that motivates you",
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => addhabitprovider.setMotivation(value),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "How many days per week you should complete the habit",
                          style: HomeStyle.textsStyleh,
                        ),
                      ),
                      MultiSelectChip(
                        initialValue: addhabitprovider.daysPerWeek,
                        onSelectionChanged: (selectedDays) {
                          addhabitprovider.setDaysPerWeek(selectedDays);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Select Start Date",
                          style: HomeStyle.textsStyleh,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: addhabitprovider.startDate,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null &&
                                picked != addhabitprovider.startDate) {
                              addhabitprovider.setStartDate(picked);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.limeAccent[400],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              "Selected Date: ${DateFormat('yyyy-MMM-dd').format(addhabitprovider.startDate)}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const ReminderPage(),
                  //           ),
                  //         );
                  //       },
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           border: Border.all(
                  //             color: Colors.limeAccent[400] ?? Colors.grey,
                  //           ),
                  //         ),
                  //         padding: const EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 16),
                  //         child: Row(
                  //           children: [
                  //             Icon(
                  //                 size: 28,
                  //                 color: Colors.limeAccent[400],
                  //                 Icons.alarm),
                  //             const SizedBox(width: 5),
                  //             const Text(
                  //               'Reminders',
                  //               style: HomeStyle.textsStyleh,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<int> initialValue;
  final Function(List<int>) onSelectionChanged;

  MultiSelectChip({
    required this.initialValue,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<int> selectedChoices = [];

  @override
  void initState() {
    selectedChoices = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> choices = [];
    for (int i = 1; i <= 7; i++) {
      choices.add(
        ChoiceChip(
          label: Text(i.toString()),
          selected: selectedChoices.contains(i),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(i)
                  ? selectedChoices.remove(i)
                  : selectedChoices.add(i);
            });
            widget.onSelectionChanged(selectedChoices);
          },
        ),
      );
    }
    return Wrap(
      children: choices,
    );
  }
}
