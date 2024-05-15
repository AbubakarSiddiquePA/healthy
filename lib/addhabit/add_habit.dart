import 'package:flutter/material.dart';
import 'package:healthy/const/homestyle.dart';
import 'package:healthy/providers/authprovider/habitprovider/addhabitprovider.dart';
import 'package:healthy/reminders/reminders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _motivationController = TextEditingController();
  // int _daysPerWeek = 1;
  // DateTime _startDate = DateTime.now();

  // void _saveHabit() {
  //   if (_formKey.currentState!.validate()) {
  //     Habit newHabit = Habit(
  //       id: "",
  //       name: _nameController.text,
  //       motivation: _motivationController.text,
  //       daysPerWeek: _daysPerWeek,
  //       startDate: _startDate,
  //     );
  //     FirebaseFirestore.instance
  //         .collection("habitsCollection")
  //         .add(newHabit.toMap());

  //     Navigator.pop(context, newHabit);
  //   }
  // }

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
                    addhabitprovider.habitNameController.clear();
                    addhabitprovider.motivationNameController.clear();
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
              padding: const EdgeInsets.all(16.00),
              child: Form(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
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
                          border: const OutlineInputBorder()),
                      onChanged: (value) =>
                          addhabitprovider.setHabitName(value),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: addhabitprovider.motivationNameController,
                      decoration: InputDecoration(
                          labelText: "Motivate yourself",
                          suffixIcon: const Icon(Icons.sports_gymnastics),
                          suffixIconColor: Colors.limeAccent[400],
                          hintText: "Write something that motivates you",
                          border: const OutlineInputBorder()),
                      onChanged: (value) =>
                          addhabitprovider.setMotivation(value),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "How many days per week you should complete the habit",
                            style: HomeStyle.textsStyleh,
                          ),
                        ),
                        DropdownButton<int>(
                          value: addhabitprovider.daysPerWeek,
                          onChanged: (value) =>
                              addhabitprovider.setDaysPerWeek(value!),
                          items: List.generate(
                            7,
                            (index) {
                              return DropdownMenuItem(
                                value: index + 1,
                                child: Text(
                                  "${index + 1}",
                                  style: HomeStyle.textsStyleh,
                                ),
                              );
                            },
                          ),
                          style: HomeStyle.textsStyleh,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.limeAccent[400],
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.limeAccent[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Start Date",
                            style: HomeStyle.textsStyleh,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
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
                                vertical: 10, horizontal: 16),
                            child: Text(
                              "Selected Date: ${DateFormat('yyyy-MMM-dd').format(addhabitprovider.startDate)}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                                color: Colors.limeAccent[400] ?? Colors.grey,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            // width: 150,
                            // height: 40,
                            child: const Text(
                              ' 🔔 Reminders',
                              style: HomeStyle.textsStyleh,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ));
    });
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           TextButton(
//             onPressed: _saveHabit,
//             child: const Text("Save"),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.00),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 const Text(
//                   "Habit Name",
//                 ),
//                 TextFormField(
//                   decoration:
//                       const InputDecoration(border: OutlineInputBorder()),
//                   controller: _nameController,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter a name";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text("Motivate yourself "),
//                 TextFormField(
//                   decoration:
//                       const InputDecoration(border: OutlineInputBorder()),
//                   controller: _motivationController,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter a motivation";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                     "How many days per week you should complete the habit"),
//                 DropdownButton<int>(
//                   value: _daysPerWeek,
//                   onChanged: (value) {
//                     setState(() {
//                       _daysPerWeek = value!;
//                     });
//                   },
//                   items: List.generate(
//                     7,
//                     (index) {
//                       return DropdownMenuItem(
//                         value: index + 1,
//                         child: Text("${index + 1}"),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     const Text("Start Date"),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         final DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate: _startDate,
//                           firstDate: DateTime(2024),
//                           lastDate: DateTime(2025),
//                         );
//                         if (picked != null && picked != _startDate) {
//                           setState(() {
//                             _startDate = picked;
//                           });
//                         }
//                       },
//                       child: Text(
//                         "Selected Date: ${DateFormat('yyyy-MMM-dd').format(_startDate)}",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ReminderPage(),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 202, 199, 199),
//                           ),
//                         ),
//                         width: 150,
//                         height: 40,
//                         child: const Center(
//                           child: Text(
//                             ' 🔔Reminders',
//                             style: TextStyle(fontSize: 18, color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
}
