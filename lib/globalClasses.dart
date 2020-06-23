import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Note {
  final id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateLastEdited;
  bool isPinned;

  Note({id, title, content, dateCreated, dateLastEdited, isPinned})
      : id = id ?? Uuid().v4(),
        title = title ?? '',
        content = content ?? '',
        dateCreated = dateCreated ?? DateTime.now(),
        dateLastEdited = dateLastEdited ?? DateTime.now(),
        isPinned = isPinned ?? false;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'created': dateCreated.millisecondsSinceEpoch.toString(),
        'edited': (dateLastEdited != null)
            ? dateLastEdited.millisecondsSinceEpoch.toString()
            : DateTime.now(),
        'isPinned': (isPinned == true)
            ? 1
            : 0 //  for later use for integrating archiving
      };

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["created"])),
      dateLastEdited:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json["edited"])),
      isPinned: (json["isPinned"] == 0) ? false : true);
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
