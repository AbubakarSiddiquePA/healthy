import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final books = snapshot.data!.docs.map((doc) {
            return Book(
              title: doc['title'],
              author: doc['author'],
              imageUrl: doc['coverImageUrl'],
              bookFileUrl: doc['bookFileUrl'],
            );
          }).toList();

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Image.network(books[index].imageUrl),
                  title: Text(books[index].title),
                  subtitle: Text(books[index].author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: CircleAvatar(
                            backgroundColor: Colors.limeAccent[400],
                            child: const Icon(Icons.picture_as_pdf)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(books[index].title),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(books[index].imageUrl),
                                  const SizedBox(height: 10),
                                  Text('Author: ${books[index].author}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: CircleAvatar(
                            backgroundColor: Colors.limeAccent[400],
                            child: const Icon(Icons.download)),
                        onPressed: () async {
                          final url = books[index].bookFileUrl;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String imageUrl;
  final String bookFileUrl;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.bookFileUrl,
  });
}
