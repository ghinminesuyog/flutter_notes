import 'package:flutter/material.dart';
import 'dbOperations.dart';
import 'globalClasses.dart';

class NotePage extends StatefulWidget {
  @required
  // final Note note;
  static const route = '/note';
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Note note = new Note();
  TextEditingController titleTextController = new TextEditingController();
  TextEditingController contentTextController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleTextController.dispose();
    contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotePageScreenArguments args = ModalRoute.of(context).settings.arguments;

    setState(() {
      note = args.note;
      titleTextController = TextEditingController(text: note.title);
      contentTextController = TextEditingController(text: note.content);
      print('Id is ${note.id}');
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              DBProvider.db.newNote(Note(
                title: titleTextController.text,
                content: contentTextController.text,
                dateCreated: DateTime.now(),
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteNote(note);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              shareNote(note);
            },
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: TextField(
            controller: titleTextController,
            style: TextStyle(fontWeight: FontWeight.bold),
            minLines: 1,
            maxLines: 99999,
            autofocus: true,
            decoration: new InputDecoration.collapsed(hintText: 'Title'),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: contentTextController,
              minLines: 1,
              maxLines: 99999,
              autofocus: true,
              decoration: new InputDecoration.collapsed(hintText: 'Text'),
            ),
          ),
        ),
      ]),
    );
  }
}
