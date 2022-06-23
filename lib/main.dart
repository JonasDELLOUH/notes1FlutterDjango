import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:notes1/homepage.dart';
import 'package:notes1/notesApi.dart';
import 'package:notes1/sqlite.dart';

import 'note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    List<Note> notes;
    notes = await Sqlite.selectAllNoteOffLine();
    for (var note in notes) {
      NotesApi().addNote(note.title, note.text);
      Sqlite.updateNoteOnline(note.id);
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

