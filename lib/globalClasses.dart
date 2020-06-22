import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:ui';

class Note {
  int id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateLastEdited;
  bool isPinned = false;

  // Note(
  //     {this.id,
  //     this.title,
  //     this.content,
  //     this.dateCreated,
  //     this.dateLastEdited,
  //     });

      Note({id, title,content,dateCreated,dateLastEdited,})
      : title = title ?? '',
        content = content ?? '' ,
        dateCreated = dateCreated ?? DateTime.now(),
                dateLastEdited = dateLastEdited ?? DateTime.now()

        ;

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
//      'id': id,  since id is auto incremented in the database we don't need to send it to the insert query.
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'date_created': epochFromDate(dateCreated),
      'date_last_edited': epochFromDate(dateLastEdited),
      'is_pinned': isPinned //  for later use for integrating archiving
    };
    if (forUpdate) {
      data["id"] = this.id;
    }
    return data;
  }

// Converting the date time object into int representing seconds passed after midnight 1st Jan, 1970 UTC
  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  void pinThisNote() {
    isPinned = true;
  }
}

class MyAppDrawer extends StatefulWidget {
  @override
  _MyAppDrawerState createState() => _MyAppDrawerState();
}

class _MyAppDrawerState extends State<MyAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DrawerHeader(
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Text('Notes'),
                ],
              );
            }),
      ),
    );
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notes'),
    );
  }
}

var globalDrawer = MyAppDrawer();

class CheckViewStyle {
  static bool isStaggeredView = false;
}

var staggeredViewStream = StreamController<bool>();

class NotePageScreenArguments {
  final Note note;
  NotePageScreenArguments({this.note});
}
