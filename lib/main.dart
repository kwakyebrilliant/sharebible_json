import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String selectedOption = "KJV"; // Initial selected option

  // List of available options
  List<String> options = ["KJV", "ASV", "WEB"];

  String? selectedBook; // Use nullable type
  Map<String, List<String>> bookItems = {
    'Gen.': ['CH 1', 'CH 2', 'CH 3', 'CH 4', 'CH 5'],
    'Exo.': ['CH 1', 'CH 2', 'CH 3', 'CH 4', 'CH 5'],
    'Lev.': ['CH 1', 'CH 24', 'CH 100', 'CH 112', 'CH 120'],
    'Pro.': ['CH 1', 'CH 10', 'CH 13', 'CH 24', 'CH 35'],
    'Isa.': ['CH 1', 'CH 40', 'CH 66', 'CH 67', 'CH 68'],
  };

  void toggleVisibility(String? book) {
    setState(() {
      if (selectedBook == book) {
        selectedBook = null; // Use null instead of an empty string
      } else {
        selectedBook = book;
      }
    });
  }

  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              DropdownButton<String>(
                value: selectedOption,
                onChanged: (newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
                items: options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                child: const Text('ShareBible Json'),
              ),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.teal,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: bookItems.keys.map((book) {
                  return Container(
                    height: 55.0,
                    width: 55.0,
                    child: TextButton(
                      onPressed: () {
                        toggleVisibility(book);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: Text(
                        book,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: selectedBook != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: selectedBook != null
                    ? bookItems[selectedBook!]!
                        .map((chapter) => Text(chapter))
                        .toList()
                    : [],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  readJson();
                },
                child: const Center(
                  child: Text('Load data'),
                ))
          ],
        ),
      ),
    );
  }
}
