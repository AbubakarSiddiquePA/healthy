import 'package:flutter/material.dart';
import 'package:healthy/challenges/const%20challenges/const.dart';
import 'package:healthy/challenges/selflovee.dart/selflvchat.dart';

class SelfLove extends StatelessWidget {
  const SelfLove({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(
            "Self Love Group",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
            child: SizedBox(
              width: 500,
              height: 150,
              child: Image.asset(
                "images/loveeee.jpeg",
                width: 400,
                height: 300,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "There’s only ONE person that has ability to make you happy.. and it’s YOU.this self-love challenge will boost your confidence and self-steem,and i hope you start treating yourself better.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Send request to \n join group",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 225, 222, 222),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => SelfLoveChat()));
                    },
                    icon: const Icon(Icons.chat)),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
