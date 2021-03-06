import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes1/sqlite.dart';

class UpdateNotePage extends StatefulWidget {
  final String title;
  final String text;
  final int id;
  const UpdateNotePage({Key? key, required this.title, required this.text, required this.id}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController textcontroller = TextEditingController();
  Client client = Client();

  _updateNote() async{
    Sqlite.updateNote(widget.id, titlecontroller.text, textcontroller.text);
    Navigator.of(context).pop();
  }

  @override
  void initState(){
    titlecontroller.text =  widget.title;
    textcontroller.text = widget.text;
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
          "Update this Note",
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
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: "Body for note",
                ),
                controller: textcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _updateNote();
                },
                style: ElevatedButton.styleFrom(primary: Colors.teal),
                child: const Text("Update"),
              )
            ],
          )),
    );
  }
}
