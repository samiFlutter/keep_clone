import 'package:flutter/material.dart';
import 'package:keep_clone/model/label_model.dart';

import '../service/my_databasehelper.dart';

class NavDrawer extends StatelessWidget {
  int? selectedId;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                'assets/google_keep.png',
                width: 150,
              ),
            ],
          ),
          // DrawerHeader(
          //   // child: Text(
          //   //   'Google Keep',
          //   //   style: TextStyle(color: Colors.white, fontSize: 25),
          //   // ),
          //   child: Image.asset('assets/google_keep.png'),
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //     // image: DecorationImage(
          //     //     fit: BoxFit.fill,
          //     //     image: AssetImage('assets/images/cover.jpg')
          //     //     )
          //   ),
          // ),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Text('Labels'),
          //     SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.3,
          //     ),
          //     TextButton(
          //       style: TextButton.styleFrom(
          //         primary: Colors.black,
          //       ),
          //       onPressed: () {},
          //       child: Text('Edit'),
          //     )
          //   ],
          // ),
          // ListTile(
          //   leading: Icon(Icons.label_outline),
          //   title: Text('work'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.add),
          //   title: Text('Create new label '),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          FutureBuilder<List<LabelModel>>(
            future: DatabaseHelper.instance.getLabelModels(),
            builder: (BuildContext context,
                AsyncSnapshot<List<LabelModel>> snapshot) {
              return snapshot.data == null
                  ? Container(
                      child: Text('snapshot null'),
                    )
                  : snapshot.data!.isEmpty
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              alignment: Alignment.bottomLeft,
                              child: Text('db empty'),
                            ),
                            ListTile(
                              leading: Icon(Icons.add),
                              title: Text('Create new label '),
                              onTap: () => {Navigator.of(context).pop()},
                            ),
                          ],
                        )
                      : ListView(
                          children: snapshot.data!.map((label) {
                            return Center(
                              child: Card(
                                color: selectedId == label.id
                                    ? Colors.amber
                                    : Colors.white,
                                child: ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Create new label '),
                                  onTap: () => {Navigator.of(context).pop()},
                                ),
                              ),
                            );
                          }).toList(),
                        );
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
        ],
      ),
    );
  }
}
