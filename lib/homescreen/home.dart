import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:healthy/addhabit/add_habit.dart';
import 'package:healthy/aprilpage/april.dart';
import 'package:healthy/authentication/signin/signin.dart';
import 'package:healthy/challenges/const%20challenges/Challenges.dart';
import 'package:healthy/const/homestyle.dart';
import 'package:healthy/const/tabbarstyle.dart';
import 'package:healthy/habitmodelclass/habit_model.dart';
import 'package:healthy/models/reminder_model.dart';
import 'package:healthy/read/read.dart';
import 'package:healthy/reminders/add_reminder.dart';
import 'package:healthy/reminders/reminders.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Habit> habits = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("habitsCollection").get();
      setState(() {
        habits = snapshot.docs
            .map((doc) =>
                Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      });
    } catch (e) {
      print("Error fetching habits: $e");
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await FirebaseFirestore.instance
          .collection("habitsCollection")
          .doc(habitId)
          .delete();
      setState(() {
        habits.removeWhere((habit) => habit.id == habitId);
      });
      print("Habit deleted successfully");
    } catch (e) {
      print("Error deleting habit: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Healthy",
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.limeAccent[400],
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPage(),
                      ),
                    ).then((newHabit) {
                      if (newHabit != null) {
                        setState(() {
                          habits.add(newHabit);
                        });
                      }
                    });
                  },
                  icon: const Icon(color: Colors.white, Icons.add),
                  iconSize: 28,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black38,
                ),
                child: Text(
                  'Health',
                  style: HomeStyle.textsStylehome,
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    Text('About'),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.info)
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Row(
                  children: [
                    Text('Share'),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.share)
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('LogOut'),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("signout");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginForm(),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("You are logged out")));
                        });
                      },
                      icon: const Icon(Icons.logout),
                    )
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        bottomNavigationBar: FlashyTabBar(
          backgroundColor: Colors.black,
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false,
          onItemSelected: (Index) => setState(() {
            _selectedIndex = Index;
            switch (_selectedIndex) {
              case 1:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AprilCalender()),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReminderPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListScreen()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChallengesPage()),
                );
                break;
              default:
            }
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: Text(
                'Home',
                style: TabBarStyles.textsStyle,
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.alarm),
              title: Text(
                '''Reminder's''',
                style: TabBarStyles.textsStyle,
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.read_more),
              title: Text(
                'Read',
                style: TabBarStyles.textsStyle,
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.chat),
              title: Text(
                'Community',
                style: TabBarStyles.textsStyle,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25)),
                      margin: const EdgeInsets.all(10),
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: Image.asset("images/giphy.gif"),
                      )),
                  const Spacer(),
                  const SizedBox(width: 4),
                  _buildDateText("Wed", 15),
                  const SizedBox(width: 4),
                  _buildDateText("Thu", 16),
                  const SizedBox(width: 4),
                  _buildDateText("Fri", 17),
                  const SizedBox(width: 4),
                  _buildDateText("Sat", 18),
                ],
              ),
            ),
            const SizedBox(height: 50),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your habits define your future',
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              pause: const Duration(seconds: 2),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            habits.isEmpty
                ? const Text(
                    "There are no habits yet.... \ntap the + button to add few",
                    style: TextStyle(fontSize: 18),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          Habit habit = habits[index];
                          return Card(
                            color: Colors.limeAccent[400],
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 5.0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.favorite),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        habit.name,
                                        style: const TextStyle(
                                          letterSpacing: 3,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Motivation:",
                                          style: HomeStyle.textsStylecard,
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              habit.motivation,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Days per Week:",
                                          style: HomeStyle.textsStylecard,
                                        ),
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              habit.daysPerWeek.join(', '),
                                              style: HomeStyle.textsStylecard,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Start Date:",
                                          style: HomeStyle.textsStylecard,
                                        ),
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${DateFormat('yyyy-MMM-dd').format(habit.startDate)}",
                                              style: HomeStyle.textsStylecard,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          deleteHabit(habit.id);
                                          setState(() {
                                            habits.removeAt(index);
                                          });
                                        },
                                        icon: const CircleAvatar(
                                          child: Icon(Icons.delete,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AddReminder(),
                                                ));
                                          },
                                          child: const Text(
                                              style: TextStyle(fontSize: 16),
                                              "Set Reminder"))
                                    ],
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

Widget _buildDateText(String day, int date) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Colors.limeAccent[400],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3))
        ]),
    child: Column(
      children: [
        Text(day, style: HomeStyle.textsStyleh),
        const SizedBox(
          height: 4,
        ),
        Text(date.toString(), style: HomeStyle.textsStyleh),
      ],
    ),
  );
}
