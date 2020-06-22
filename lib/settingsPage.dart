import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dbOperations.dart';
import 'globalClasses.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                value: CheckViewStyle.isStaggeredView,
                items: viewDropDownItems,
                onChanged: (val) {
                  setState(() {
                    CheckViewStyle.isStaggeredView = val;
                    print('Stag view? ${CheckViewStyle.isStaggeredView}');
                    staggeredViewStream.add(val);
                  });
                }),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RaisedButton(
              onPressed: clearLocalStrorage,
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
