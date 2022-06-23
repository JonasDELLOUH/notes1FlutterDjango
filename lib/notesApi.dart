
import 'dart:convert';

import 'package:http/http.dart';
import 'package:notes1/secret.dart';

import 'note.dart';

class NotesApi{

  Client client = Client();

  addNote(String title, String text) async {
    var response = await client.post(Uri.parse(baseURL),
        body: {
          "title" : title,
          "text" : text
        }
    );
  }

  _updateNote(String id, String title, String text) async{
    var response = await client.put(Uri.parse(baseURL + id + "/"),
        body: {
          "title" : title,
          "text" : text
        }
    );
  }

  _deleteNote(int id) async {
    var response = await client.delete(
        Uri.parse(baseURL + id.toString() + "/"));
  }

  Future<List<Note>> _retrieveNote() async {
    List<Note> notes = [];
    List response = json.decode((await client.get(Uri.parse(baseURL))).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    return notes;
  }
}