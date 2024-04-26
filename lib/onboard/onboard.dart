import 'package:flutter/material.dart';
import 'package:healthy/homescreen/home.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Alright Lets Start building \nyour first habit",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(44.0),
              child: RichText(
                text: const TextSpan(
                    text: "Start with tiny habits and end with ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "remarkable ",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      TextSpan(
                        text: "results",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ]),
              ),
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tap Me",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  icon: const Icon(Icons.favorite),
                  iconSize: 40,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
