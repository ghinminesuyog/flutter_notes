import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Note {
  String id;
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

class CheckViewStyle {
  static bool isStaggeredView = false;
}

var staggeredViewStream = StreamController<bool>();

class NotePageScreenArguments {
  final Note note;
  NotePageScreenArguments({this.note});
}
