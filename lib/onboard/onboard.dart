import 'package:flutter/material.dart';

class onboard extends StatelessWidget {
  const onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Text("Alright Lets Start building your first habit")],
        ),
      ),
    );
  }
}
