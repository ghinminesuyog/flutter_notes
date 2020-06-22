import 'package:flutter/material.dart';
import 'globalClasses.dart';

Color secondaryColour = getFakePrimaryColor();
Color primaryColour = getFakeSecondaryColor();

Color getFakePrimaryColor() {
  return Colors.yellow;
}

Color getFakeSecondaryColor() {
  return Colors.amber;
}

getFutureFakeNotes(){
  // return null;
  return [
    Note(
        id: 1,
        title: 'Note number 1',
        dateCreated: DateTime.now(),
        dateLastEdited: DateTime.now(),
        content: 'Content of note 1'),
    Note(
        id: 2,
        title:
            'Note title 3 very long very very very very very very very very very very very very very very very very very very very very very very',
        dateCreated: DateTime.now(),
        dateLastEdited: DateTime.now(),
        content: 'Content of note 2'),
    Note(
        id: 3,
        title: '',
        dateCreated: DateTime.now(),
        dateLastEdited: DateTime.now(),
        content:
            'Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n Content of note 3 \n')
  ];
}

getFakeNotes() async {
  var fakeNotes = await getFutureFakeNotes();
  return fakeNotes;
}

shareNote(Note note) {
  print('Sharing');
}

deleteNote(Note note) {
  print('Deleting');
}



clearLocalStrorage(){
  print('Deleted local storage');
}