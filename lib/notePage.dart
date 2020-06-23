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

  _showSnackbar(
      {@required context, @required String message, @required bool dismiss}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    if (dismiss) {
      Scaffold.of(context)
          .showSnackBar(snackBar)
          .closed
          .then((value) => Navigator.pop(context));
    }
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
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (contentTextController.text.isEmpty) {
                  _showSnackbar(
                      context: context,
                      message: 'Cannot save an empty note!',
                      dismiss: false);
                } else {
                  _showSnackbar(
                      context: context, message: 'Saved!', dismiss: false);

                  DBProvider.db.newNote(Note(
                    id: note.id,
                    title: titleTextController.text,
                    content: contentTextController.text,
                    dateLastEdited: DateTime.now(),
                    dateCreated: note.dateCreated,
                  ));
                }
              },
            );
          }),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                var res = await DBProvider.db.deleteNote(note.id);
                print(res);
                if (res == 1) {
                  _showSnackbar(
                      context: context, message: 'Deleted!', dismiss: true);
                } else {
                  _showSnackbar(
                      context: context,
                      message: 'Some error occured. Could not delete!',
                      dismiss: false);
                }
              },
            );
          }),
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
            maxLines: 10,
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
