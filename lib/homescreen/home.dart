import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/addhabit/add_habit.dart';
import 'package:healthy/authentication/signin/signin.dart';
import 'package:healthy/modelclasshabit/addhabit_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Habit> habit = [];
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
                    ));
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
          onTap: (value) {
            // Respond to item press.
          },
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
              label: "2024",
              icon: Icon(Icons.calendar_view_day_rounded),
            ),
            BottomNavigationBarItem(
              label: "Community",
              icon: Icon(Icons.chat),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
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
                    "sat \n27",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "sun \n28",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),

                  Text(
                    "mon \n29",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),

                  Text(
                    "tue \n30",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "There are no habits yet.... \ntap the + button to add few",
              style: TextStyle(fontSize: 18),
              // textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "There are no habits yet.... \ntap the + button to add few",
              style: const TextStyle(fontSize: 18),
              // textAlign: TextAlign.center,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {},
            ))
          ],
        ),
      ),
    );
  }
}
