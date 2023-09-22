import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BibleBooksList(),
    );
  }
}

class BibleBooksList extends StatefulWidget {
  @override
  _BibleBooksListState createState() => _BibleBooksListState();
}

class _BibleBooksListState extends State<BibleBooksList> {
  List<String> bibleBooks = []; // List to store the Bible books in order

  @override
  void initState() {
    super.initState();
    loadJsonData().then((String jsonContent) {
      final jsonData = json.decode(jsonContent);
      final verses = jsonData['verses'];

      // Define a custom order for the Bible books based on their position
      final Map<String, int> bookOrder = {
        'Genesis': 1,
        'Exodus': 2,
        'Leviticus': 3,
        'Numbers': 4,
        'Deuteronomy': 5,
        'Joshua': 6,
        'Judges': 7,
        'Ruth': 8,
        '1 Samuel': 9,
        '2 Samuel': 10,
        '1 Kings': 11,
        '2 Kings': 12,
        '1 Chronicles': 13,
        '2 Chronicles': 14,
        'Ezra': 15,
        'Nehemiah': 16,
        'Esther': 17,
        'Job': 18,
        'Psalms': 19,
        'Proverbs': 20,
        'Ecclesiastes': 21,
        'Song of Solomon': 22,
        'Isaiah': 23,
        'Jeremiah': 24,
        'Lamentations': 25,
        'Ezekiel': 26,
        'Daniel': 27,
        'Hosea': 28,
        'Joel': 29,
        'Amos': 30,
        'Obadiah': 31,
        'Jonah': 32,
        'Micah': 33,
        'Nahum': 34,
        'Habakkuk': 35,
        'Zephaniah': 36,
        'Haggai': 37,
        'Zechariah': 38,
        'Malachi': 39,
        'Matthew': 40,
        'Mark': 41,
        'Luke': 42,
        'John': 43,
        'Acts': 44,
        'Romans': 45,
        '1 Corinthians': 46,
        '2 Corinthians': 47,
        'Galatians': 48,
        'Ephesians': 49,
        'Philippians': 50,
        'Colossians': 51,
        '1 Thessalonians': 52,
        '2 Thessalonians': 53,
        '1 Timothy': 54,
        '2 Timothy': 55,
        'Titus': 56,
        'Philemon': 57,
        'Hebrews': 58,
        'James': 59,
        '1 Peter': 60,
        '2 Peter': 61,
        '1 John': 62,
        '2 John': 63,
        '3 John': 64,
        'Jude': 65,
        'Revelation': 66,
      };

      // Sort the Bible books based on their custom order
      verses.sort((a, b) {
        final int orderA = bookOrder[a['book_name']] ?? 9999;
        final int orderB = bookOrder[b['book_name']] ?? 9999;
        return orderA.compareTo(orderB);
      });

      // Extract unique book names
      final Set<String> uniqueBooks = {};
      for (var verse in verses) {
        uniqueBooks.add(verse['book_name']);
      }

      setState(() {
        bibleBooks = uniqueBooks.toList();
      });
    });
  }

  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/kjv.json');
  }

  void _navigateToChaptersVerses(BuildContext context, String selectedBook) {
    // You can navigate to a new screen and pass the selected book to it
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BibleChaptersVersesScreen(selectedBook),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Books List'),
      ),
      body: ListView.builder(
        itemCount: bibleBooks.length,
        itemBuilder: (context, index) {
          final selectedBook = bibleBooks[index];
          return ListTile(
            title: Text(selectedBook),
            onTap: () {
              _navigateToChaptersVerses(context, selectedBook);
            },
          );
        },
      ),
    );
  }
}

class BibleChaptersVersesScreen extends StatelessWidget {
  final String? selectedBook;

  BibleChaptersVersesScreen(this.selectedBook);

  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/kjv.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedBook!),
      ),
      body: FutureBuilder<String>(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available.');
          } else {
            final jsonData = json.decode(snapshot.data!);
            final verses = jsonData['verses'];

            // Filter chapters based on the selected book
            final List<int> chapters = [];
            for (var verse in verses) {
              if (verse['book_name'] == selectedBook) {
                final chapter = verse['chapter'];
                if (!chapters.contains(chapter)) {
                  chapters.add(chapter);
                }
              }
            }

            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapterNumber = chapters[index];
                return ListTile(
                  title: Text('Chapter $chapterNumber'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BibleVersesScreen(
                          selectedBook!,
                          chapterNumber,
                          verses,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class BibleVersesScreen extends StatelessWidget {
  final String selectedBook;
  final int selectedChapter;
  final List<dynamic> verses;

  BibleVersesScreen(this.selectedBook, this.selectedChapter, this.verses);

  @override
  Widget build(BuildContext context) {
    final List chapterVerses = verses
        .where(
          (verse) =>
              verse['book_name'] == selectedBook &&
              verse['chapter'] == selectedChapter,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedBook Chapter $selectedChapter'),
      ),
      body: ListView.builder(
        itemCount: chapterVerses.length,
        itemBuilder: (context, index) {
          final verse = chapterVerses[index];
          return ListTile(
            title: Text('Verse ${verse['verse']}'),
            subtitle: Text(verse['text']),
          );
        },
      ),
    );
  }
}
