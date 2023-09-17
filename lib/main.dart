import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ShareBible(),
  ));
}

class ShareBible extends StatefulWidget {
  @override
  State<ShareBible> createState() => _ShareBibleState();
}

class _ShareBibleState extends State<ShareBible> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('ShareBible Json'),
        centerTitle: false,
        backgroundColor: Colors.amber[800],
        elevation: 0.0,
      ),
    );
  }
}
