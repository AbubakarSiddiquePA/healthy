import 'package:flutter/material.dart';

class SelfLoveChat extends StatefulWidget {
  @override
  _SelfLoveChatState createState() => _SelfLoveChatState();
}

class _SelfLoveChatState extends State<SelfLoveChat> {
  List<String> messages = [];
  TextEditingController messageController = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Are you sure you want to leave the group?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          // Implement leaving the group logic here
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
        title: const Text('Self Love Group'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _sendMessage(messageController.text);
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
