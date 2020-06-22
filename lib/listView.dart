import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dbOperations.dart';
import 'globalClasses.dart';
import 'notePage.dart';
import 'settingsPage.dart';

class NoteListView extends StatefulWidget {
  @override
  _NoteListViewState createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  // List<Note> notes = [];

  @override
  void initState() {
    super.initState();
  }

  futureListView() {
    return FutureBuilder(
      future: getFakeNotes(),
      builder: (context, snap) {
        if (snap.hasData) {
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (cntxt, ind) {
                Note note = (snap.data)[ind];

                String noteTitle = '';
                if (note.title != null) {
                  noteTitle = note.title;
                  if (noteTitle.length > 16) {
                    noteTitle = noteTitle.substring(0, 15) + '...';
                  }
                }
                String noteContent = '';
                if (note.content != null) {
                  noteContent = note.content;
                  if (noteContent.length > 16) {
                    noteContent = noteContent.substring(0, 15) + '...';
                  }
                }
                DateTime dateEditedOn = note.dateLastEdited;
                String editedOn =
                    DateFormat('MM/dd hh:mm').format(dateEditedOn);

                return Container(
                  color: (ind % 2 == 0) ? Colors.white : Color(0x00FFFFFF),
                  child: ListTile(
                    onTap: () {
                      print('Note is ${note.title}');
                      Navigator.pushNamed(context, '/note',arguments: NotePageScreenArguments(note: note
                      ));
                    },
                    title: Text(noteTitle),
                    subtitle: Text(noteContent),
                    trailing: Text(editedOn),
                  ),
                );
              });
        } else if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Center(
            child: Text('You do not have any notes. Go ahead and create some.'),
          );
        
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    // Scaffold(
        
    //     body: 
        futureListView();
        // );
  }
}
