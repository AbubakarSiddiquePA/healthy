import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String message;

  ChatMessage({required this.sender, required this.message});
}

class GroupChat extends StatefulWidget {
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List<ChatMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  String currentUser = 'User1'; // Change this to simulate different users

  void _sendMessage(String message) {
    setState(() {
      messages.add(ChatMessage(sender: currentUser, message: message));
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
                    title:
                        const Text("Are you sure you want to leave the group?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text("Yes"),
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
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('Chat Group'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                ChatMessage chatMessage = messages[index];
                bool isCurrentUser = chatMessage.sender == currentUser;
                return ListTile(
                  title: Text(
                    '${chatMessage.sender}: ${chatMessage.message}',
                    style: TextStyle(
                      color: isCurrentUser ? Colors.blue : Colors.black,
                      fontWeight:
                          isCurrentUser ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: isCurrentUser
                      ? const Text('You', style: TextStyle(color: Colors.blue))
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      _sendMessage(messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
