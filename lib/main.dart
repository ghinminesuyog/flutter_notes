import 'package:flutter/material.dart';
import 'package:flutter_notes/dbOperations.dart';
import 'listView.dart';
import 'notePage.dart';
import 'settingsPage.dart';
// import 'package:notes/notePage.dart';
import 'staggeredView.dart';
import 'globalClasses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // '/': (cntxt) => HomeScreen(),
        // NotePage.route: (context) => NotePage(),

        '/settings': (cntxt) => SettingsPage(),
        '/home': (cntxt) => HomeScreen(),
        '/note': (cntxt) => NotePage(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isStaggeredView = false;
  @override
  void initState() {
    super.initState();
    staggeredViewStream.stream.listen((event) {
      setState(() {
        isStaggeredView = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          title: Text('Home'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/note',
                arguments: NotePageScreenArguments(note: Note()));
            setState(() {});
          },
          child: Icon(Icons.add),
        ),
        body: (isStaggeredView) ? NoteGridView() : NoteListView());
  }
}
