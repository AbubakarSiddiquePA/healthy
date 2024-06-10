// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              id: doc.id,
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
                child: ListTile(
                  leading: Image.network(books[index].imageUrl),
                  title: Text(
                    books[index].title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(books[index].author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: CircleAvatar(
                            backgroundColor: Colors.limeAccent[400],
                            child: const Icon(Icons.picture_as_pdf)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerScreen(
                                  url: books[index].bookFileUrl),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.download, color: Colors.blue),
                        onPressed: () async {
                          final url = Uri.parse(books[index].bookFileUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
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

  // ignore: unused_element
  // Future<void> _requestStoragePermission() async {
  //   if (await Permission.storage.request().isGranted) {
  //     return;
  //   } else {
  //     throw Exception('Storage permission not granted');
  //   }
  // }

  // ignore: unused_element
//   Future<void> _downloadAndSaveFile(String url, String filePath) async {
//     try {
//       await Dio().download(url, filePath);
//       print('PDF downloaded to $filePath'); // Add logging
//     } catch (e) {
//       throw Exception('Error downloading PDF: $e');
//     }
//   }
// }
}

class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String bookFileUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.bookFileUrl,
  });
}

class PdfViewerScreen extends StatefulWidget {
  final String url;

  const PdfViewerScreen({required this.url, super.key});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfController? _pdfController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndDownloadFile(widget.url);
  }

  Future<void> _checkPermissionsAndDownloadFile(String url) async {
    try {
      await _requestStoragePermission();
      String filePath = await _downloadAndSaveFile(url);
      if (mounted) {
        setState(() {
          _pdfController = PdfController(
            document: PdfDocument.openFile(filePath),
          );
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load PDF: $e')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return;
    } else {
      throw Exception('Storage permission not granted');
    }
  }

  Future<String> _downloadAndSaveFile(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/temp.pdf';

    try {
      await Dio().download(url, filePath);
      print('PDF downloaded to $filePath'); // Add logging
      return filePath;
    } catch (e) {
      throw Exception('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pdfController != null
              ? PdfView(controller: _pdfController!)
              : const Center(child: Text('Failed to load PDF')),
    );
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }
}
