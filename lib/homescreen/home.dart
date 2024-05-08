import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/addhabit/add_habit.dart';
import 'package:healthy/aprilpage/april.dart';
import 'package:healthy/authentication/signin/signin.dart';
import 'package:healthy/challenges/const%20challenges/Challenges.dart';
import 'package:healthy/modelclasshabit/addhabit_model.dart';
import 'package:healthy/read/read.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Habit> habits = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    try {
      //habitsCollection is the collection in firestore where habits are stored
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("habitsCollection").get();
      setState(() {
        habits = snapshot.docs
            .map((doc) =>
                Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("error fetching habits: $e");
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await FirebaseFirestore.instance
          .collection("habitsCollection")
          .doc(habitId)
          .delete();
      print("Habit deleted successfully");
    } catch (e) {
      print("Error deleting habit: $e");
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (_currentIndex) {
      case 1:
        // Navigate to April screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AprilCalender()),
        );
        break;
      case 2:
        // Navigate to 2024 screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookListScreen()),
        );
        break;
      case 3:
        // Navigate to Community screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChallengesPage()),
        );
        break;
      default:
      // Do nothing for other items
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Habits > future"),
          actions: [
            IconButton(
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
              icon: const Icon(Icons.add),
              iconSize: 28,
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
                  style: TextStyle(color: Colors.white),
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "April",
              icon: Icon(Icons.calendar_view_month),
            ),
            BottomNavigationBarItem(
              label: "Read",
              icon: Icon(Icons.read_more),
            ),
            BottomNavigationBarItem(
              label: "Community",
              icon: Icon(Icons.chat),
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Habit",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(), // Adds a flexible space between "Habit" and days
                  Text(
                    "sat \n04",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "sun \n05",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),

                  Text(
                    "mon \n06",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),

                  Text(
                    "tue \n07",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            habits.isEmpty
                ? const Text(
                    "There are no habits yet.... \ntap the + button to add few",
                    style: TextStyle(fontSize: 18),
                    // textAlign: TextAlign.center,
                  )
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          Habit habit = habits[index];
                          return ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  deleteHabit(habit.id);
                                  setState(() {
                                    habits.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete)),
                            title: Text(habit.name),
                            subtitle: Text(
                              "Motivation: ${habit.motivation}\nDays per Week: ${habit.daysPerWeek}\nStart Date: ${DateFormat('yyyy-MMM-dd').format(habit.startDate)}",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
