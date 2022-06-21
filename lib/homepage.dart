import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes1/create.dart';
import 'package:notes1/secret.dart';
import 'package:notes1/update.dart';
import 'package:notes1/view.dart';

import 'note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client client = Client();
  List<Note> notes = [];

  _retrieveNote() async {
    notes = [];
    List response = json.decode((await client.get(Uri.parse(baseURL))).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  _deleteNote(int id) async {
    var response = await client.delete(
        Uri.parse(baseURL + id.toString() + "/"));
    _retrieveNote();
  }

  @override
  void initState() {
    _retrieveNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.note,
          color: Colors.white,
        ),
        title: const Text(
          "Notes List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNote();
        },
        child: Container(
          child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(notes[i].title),
                  leading: IconButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UpdateNotePage(title: notes[i].title, id: notes[i]
                                .id, text: notes[i].text,)));
                  }
                    , icon: Icon(Icons.note_outlined),),
                  trailing: IconButton(onPressed: () {
                    _deleteNote(notes[i].id);
                  }, icon: const Icon(Icons.delete_forever_outlined),),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ViewNotePage(title: notes[i].title, id: notes[i]
                                .id, text: notes[i].text,)));
                  },
                );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNotePage())
          );
        },
        child: const Icon(Icons.note_add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
