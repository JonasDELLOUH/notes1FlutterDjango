import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes1/sqlite.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {

  Client client = Client();


  TextEditingController titlecontroller = TextEditingController();
  TextEditingController textcontroller = TextEditingController();

  addNote() async {
    Sqlite.addNote(titlecontroller.text, textcontroller.text);
    Navigator.of(context).pop();
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
            "Add a Note",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: "Title for note",
                ),
                controller: titlecontroller,
              ),
              const SizedBox(height: 20,),
              TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: "Body for note",
                ),
                controller: textcontroller,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {addNote();},
                style: ElevatedButton.styleFrom(primary: Colors.teal),
                child: const Text("Create"),
              )
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.note_add),
        )
    );
  }
}
