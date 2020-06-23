import 'package:flutter/material.dart';
import 'globalClasses.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'dart:convert';
import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Color secondaryColour = getFakePrimaryColor();
Color primaryColour = getFakeSecondaryColor();

Color getFakePrimaryColor() {
  return Colors.yellow;
}

Color getFakeSecondaryColor() {
  return Colors.amber;
}

// getFutureFakeNotes() {
//   // return null;
//   return [
//     Note(
//         id: 1,
//         title: 'Note number 1',
//         dateCreated: DateTime.now(),
//         dateLastEdited: DateTime.now(),
//         content: 'Content of note 1'),
//     Note(
//         id: 2,
//         title:
//             'Note title 3 very long very very very very very very very very very very very very very very very very very very very very very very',
//         dateCreated: DateTime.now(),
//         dateLastEdited: DateTime.now(),
//         content: 'Content of note 2'),
//     Note(
//         id: 3,
//         title: '',
//         dateCreated: DateTime.now(),
//         dateLastEdited: DateTime.now(),
//         content:
//             'Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n')
//   ];
// }

// getFakeNotes() async {
//   List<dynamic> fakeNotes = await getFutureFakeNotes();
//   return fakeNotes;
// }

shareNote(Note note) {
  if (note.content.isNotEmpty) {
    String subject = 'Note';
    if (note.title != '') {
      subject = note.title;
    }
    Share.share(note.content, subject: subject);
  }
}

deleteNote(Note note) async {
  print(note);
  // List<dynamic> allNotes = await getFakeNotes();

  // allNotes.removeWhere((element) {
  //   if (element.id == note.id) {
  //     print('Deleted');
  //     // print('Deleting Element is: ${element.id} and ${note.id}');
  //     return true;
  //   }
  //   print('Element is: ${element.id} and ${note.id}');
  //   return false;
  // });
  // print('the list now is: $allNotes');
}

clearLocalStrorage() {
  print('Deleted local storage');
}

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
    // if _database is null we instantiate it
  }

  initDB() async {
    print('Initializing db');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NoteDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Note ("
          "id TEXT PRIMARY KEY,"
          "title TEXT,"
          "content TEXT,"
          "created TEXT,"
          "edited TEXT,"
          "isPinned INT"
          ")");
    });
  }

  newNote(Note newNote) async {
    final db = await database;
    // var queryResult = await db.rawQuery('SELECT * FROM tagTable WHERE id="aaa"');
    // var query = await db.query('Note',where: "id = ?", whereArgs: [newNote.id]);
    // print('Query: $query');


    print('${newNote.toMap()}');

    var res = await db.insert("Note", newNote.toMap());
    return res;
  }

  getAllNotes() async {
    final db = await database;
    var res = await db.query("Note");
    return res;
  }

  deleteNote(id) async{
    final db = await database;
    var res = await db.delete('Note',where: "id = ?", whereArgs: [id]);
    return res;
  }

}
