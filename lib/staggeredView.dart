import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'globalClasses.dart';
import 'dbOperations.dart';

class NoteGridView extends StatefulWidget {
  @override
  _NoteGridViewState createState() => _NoteGridViewState();
}

class _NoteGridViewState extends State<NoteGridView> {
  // List<Note> notes = [];

  @override
  void initState() {
    super.initState();

  }

  futureStaggered() {
    return FutureBuilder(
      future: DBProvider.db.getAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StaggeredGridView.extent(
            maxCrossAxisExtent: 200,
            // crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            staggeredTiles: _staggeredTiles(snapshot.data),
            children: List.generate(snapshot.data.length, (index) {
              Note note = snapshot.data[index];
              String title = note.title;
              String content = note.content;

            
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/note',
                      arguments: NotePageScreenArguments(note: note));
                 
                },
                child: Container(
                  color: (index % 3 == 0) ? primaryColour : secondaryColour,
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
                ),
              );
            }),
          );
        } 
        else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
          return Center(child: Text('No notes to display'),);
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          return Center(child: Text('Awaiting results'),);
        }
      },
    );
  }


  List<StaggeredTile> _staggeredTiles(notes) {
    List<StaggeredTile> _tiles = [];

    for (var i = 0; i < notes.length; i++) {
      var x = 1;
      var y = 1;
      if (i % 2 == 0) {
        x = 2;
      }
      if (i % 3 == 0) {
        y = 2;
      }
      _tiles.add(StaggeredTile.count(x, y));
    }
    return _tiles;
  }

  @override
  Widget build(BuildContext context) {
    return futureStaggered();
  }
}
