import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}

class BookListScreen extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: 'Atomic Habits',
      author: 'Author 1',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Book(
      title: 'Descipline equals freedom',
      author: 'Author 2',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Book(
      title: 'Goatlife',
      author: 'Author 3',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(books[index].imageUrl),
              title: Text(books[index].title),
              subtitle: Text(books[index].author),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // Implement view book functionality
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      // Implement download book functionality
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
