import 'package:flutter/material.dart';

class DrawerAbout extends StatelessWidget {
  const DrawerAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("images/habit gif.gif"),
            const Text("Designed and Developed by \n Abubakar Siddique PA"),
          ],
        ),
      ),
    );
  }
}
