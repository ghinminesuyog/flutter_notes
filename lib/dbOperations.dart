import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalClasses.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:ui';
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

shareNote(Note note) {
  if (note.content.isNotEmpty) {
    String subject = 'Note';
    if (note.title != '') {
      subject = note.title;
    }
    Share.share(note.content, subject: subject);
  }
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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NoteDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Note ("
          "id TEXT PRIMARY KEY UNIQUE,"
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
    try {
      var res = await db.insert("Note", newNote.toMap());
      return res;
    } catch (e) {
      //Try updating jic the note already exists:
      updateNote(newNote);
      print('error is : $e');
    }
  }

  updateNote(Note note) async {
    final db = await database;
    try {
      var res = await db
          .update('Note', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
      return res;
    } catch (err) {
      print('error is: $err');
    }
  }

  getNoteById(String id) async {
    final db = await database;
  }

  getAllNotes() async {
    final db = await database;
    var res = await db.query("Note");
    return res;
  }

  deleteNote(id) async {
    final db = await database;
    var res = await db.delete('Note', where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteAllNotes() async {
    final db = await database;
    var res = await db.delete("Note", where: '1');
    return res;
  }
}

Future<bool> getViewType() async{
  final pref = await SharedPreferences.getInstance();
  return (pref.getBool('isStaggered')) ?? false;
  // return true;
}

setViewType(bool isStaggered) async{
  print('Setting to : $isStaggered');
   final pref = await SharedPreferences.getInstance();
  return pref.setBool('isStaggered',isStaggered);
}