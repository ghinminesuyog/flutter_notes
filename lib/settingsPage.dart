import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dbOperations.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool currentView = false;
  initState() {
    super.initState();
    getViewType().then((value) {
      setState(() {
        currentView = value;
      });
      print(value);
    });
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content:
                Text('This will delete all your notes. This cannot be undone.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  DBProvider.db.deleteAllNotes();
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> viewDropDownItems = [
      DropdownMenuItem(
        child: Text('List'),
        value: false,
      ),
      DropdownMenuItem(
        child: Text('Staggered'),
        value: true,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('View as'),
            trailing: DropdownButton(
                value: currentView,
                items: viewDropDownItems,
                onChanged: (val) {
                  setState(() {
                    // CheckViewStyle.isStaggeredView = val;
                    // staggeredViewStream.add(val);
                    setViewType(val);
                    currentView = val;
                  });
                }),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RaisedButton(
              onPressed: () {
                _showDeleteDialog();
              },
              color: Colors.red[400],
              child: Text('Clear local storage',
                  style: TextStyle(color: Colors.white)),
            )
          ])
        ],
      ),
    );
  }
}
