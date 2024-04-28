import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy/addhabit/add_habit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
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
                      width: 10,
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
                      width: 10,
                    ),
                    Icon(Icons.share)
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
              label: "Challenge",
              icon: Icon(Icons.more),
            ),
          ],
        ),
        body: const Column(
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
            )
          ],
        ),
      ),
    );
  }
}
