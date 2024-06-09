import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class ChatMessage {
  final String sender;
  final String message;
  final Timestamp timestamp;

  ChatMessage(
      {required this.sender, required this.message, required this.timestamp});
}

class GroupChat extends StatefulWidget {
  final String communityId;

  const GroupChat({super.key, required this.communityId});

  @override
  // ignore: library_private_types_in_public_api
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List<ChatMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  User? currentUser;
  late StreamSubscription _subscription;
  String groupName = '';

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;

    // Fetch the group name
    fetchGroupName();

    // Listen to chat messages
    _subscription = FirebaseFirestore.instance
        .collection('communities')
        .doc(widget.communityId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          messages = snapshot.docs.map((doc) {
            return ChatMessage(
              sender: doc['sender'],
              message: doc['message'],
              timestamp: doc["timestamp"] ?? Timestamp.now(),
            );
          }).toList();
        });
      }
    });
  }

  Future<void> fetchGroupName() async {
    final groupSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(widget.communityId)
        .get();

    if (groupSnapshot.exists) {
      setState(() {
        groupName = groupSnapshot['name'];
      });
    } else {
      setState(() {
        groupName = 'Group Chat';
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    if (message.isNotEmpty && currentUser != null) {
      FirebaseFirestore.instance
          .collection('communities')
          .doc(widget.communityId)
          .collection('messages')
          .add({
        'sender': currentUser!.email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      messageController.clear();
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('h:mm a dd/MMMM/yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                ChatMessage chatMessage = messages[messages.length - 1 - index];
                bool isCurrentUser = chatMessage.sender == currentUser!.email;
                return ListTile(
                  title: Align(
                    alignment: isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isCurrentUser ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: isCurrentUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatMessage.message,
                            style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            formatTimestamp(chatMessage.timestamp),
                            style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  subtitle: Align(
                    alignment: isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      isCurrentUser ? 'You' : chatMessage.sender,
                      style: TextStyle(
                        color: isCurrentUser ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
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
                    _sendMessage(messageController.text);
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
