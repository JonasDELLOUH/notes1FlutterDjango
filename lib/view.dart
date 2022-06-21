import 'package:flutter/material.dart';

class ViewNotePage extends StatefulWidget {
  final int id;
  final String title;
  final String text;
  const ViewNotePage({Key? key, required this.id, required this.title, required this.text}) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Text(widget.text),
      ),
    );
  }
}
