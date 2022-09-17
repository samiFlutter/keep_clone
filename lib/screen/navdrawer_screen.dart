import 'package:flutter/material.dart';
import 'package:keep_clone/model/label_model.dart';
import 'package:keep_clone/screen/new_lebel_screen.dart';

import '../service/my_databasehelper.dart';

class NavDrawer extends StatelessWidget {
  int? selectedId;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<List<LabelModel>>(
        future: DatabaseHelper.instance.getLabelModels(),
        builder:
            (BuildContext context, AsyncSnapshot<List<LabelModel>> snapshot) {
          return snapshot.data == null
              ? Container(
                  child: Text('snapshot null'),
                )
              : snapshot.data!.isEmpty
                  ? Column(
                      children: upList(context) + downList(context),
                    )
                  : ListView(
                      children: upList(context) +
                          snapshot.data!.map((label) {
                            return Center(
                              child: Card(
                                color: selectedId == label.id
                                    ? Colors.amber
                                    : Colors.white,
                                child: ListTile(
                                  leading: Icon(Icons.label_outline),
                                  title: Text(label.name),
                                  onTap: () => {},
                                ),
                              ),
                            );
                          }).toList() +
                          downList(context),
                    );
        },
      ),
    );
  }

  List<Widget> upList(BuildContext context) {
    return <Widget>[
      Row(
        children: [
          Image.asset(
            'assets/google_keep.png',
            width: 150,
          ),
        ],
      ),
      ListTile(
        leading: Icon(Icons.lightbulb_outline_rounded),
        title: Text('Notes'),
        onTap: () => {
          Navigator.pop(context),
        },
      ),
      ListTile(
        leading: Icon(Icons.notifications_outlined),
        title: Text('Reminders'),
        onTap: () => {Navigator.of(context).pop()},
      ),
      Divider(
        height: 10,
        thickness: 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Labels'),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewLabelScreen()),
              );
            },
            child: Text('Edit'),
          )
        ],
      ),
    ];
  }

  List<Widget> downList(BuildContext context) {
    return <Widget>[
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Create new label '),
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewLabelScreen()),
          )
        },
      ),
      Divider(
        height: 10,
        thickness: 1,
      ),
      ListTile(
        leading: Icon(Icons.archive_outlined),
        title: Text('Archive'),
        onTap: () => {Navigator.of(context).pop()},
      ),
      ListTile(
        leading: Icon(Icons.delete),
        title: Text('Deleted'),
        onTap: () => {Navigator.of(context).pop()},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () => {Navigator.of(context).pop()},
      ),
      ListTile(
        leading: Icon(Icons.help_outline),
        title: Text('Help & feedback'),
        onTap: () => {Navigator.of(context).pop()},
      ),
    ];
  }
}
