import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShareBible(),
  ));
}

class ShareBible extends StatefulWidget {
  @override
  State<ShareBible> createState() => _ShareBibleState();
}

class _ShareBibleState extends State<ShareBible> {
  final List<Map<String, dynamic>> bible = [
    {
      'book': 'Gen',
      "chapterNumber": 1,
      "verseNumber": 1,
      "value": "In the beginning, God created the heavens and the earth.  "
    },
    {
      'book': 'Gen',
      "chapterNumber": 2,
      "verseNumber": 1,
      "value": "In the, God created the heavens and the earth.  "
    },
    {
      'book': 'Exo',
      "chapterNumber": 1,
      "verseNumber": 1,
      "value": "In the beginning, God created the heavens and the earth.  "
    },
    {
      'book': 'Exo',
      "chapterNumber": 2,
      "verseNumber": 1,
      "value": "In the, God created the heavens and the earth.  "
    },
    {
      'book': 'Lev',
      "chapterNumber": 1,
      "verseNumber": 1,
      "value": "In the beginning, God created the heavens and the earth.  "
    },
    {
      'book': 'Lev',
      "chapterNumber": 2,
      "verseNumber": 1,
      "value": "In the, God created the heavens and the earth.  "
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('ShareBible Json'),
        centerTitle: false,
        backgroundColor: Colors.teal,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: const Row(
                  children: [Text('data')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
