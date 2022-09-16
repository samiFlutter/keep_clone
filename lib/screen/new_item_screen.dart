import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:keep_clone/model/simple_model.dart';
import 'package:keep_clone/service/my_databasehelper.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key}) : super(key: key);

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  bool bt1 = true;
  bool bt2 = true;
  bool bt3 = true;

  var bt1Icon = Icons.push_pin_outlined;
  var bt2Icon = Icons.notification_add_outlined;
  var bt3Icon = Icons.archive_outlined;
  Color bgcolor = Colors.white;

  var titleController = TextEditingController();
  var notrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                bt1Icon,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  bt1
                      ? bt1Icon = Icons.push_pin_outlined
                      : bt1Icon = Icons.push_pin;
                  bt1 = !bt1;
                });
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                bt2Icon,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  bt2
                      ? bt2Icon = Icons.notification_add_outlined
                      : bt2Icon = Icons.notification_add;
                  bt2 = !bt2;
                });
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                bt3Icon,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  bt3
                      ? bt3Icon = Icons.archive_outlined
                      : bt3Icon = Icons.archive;
                  bt3 = !bt3;
                });

                // do something
              },
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: bgcolor,
        ),
        body: Container(
          color: bgcolor,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: titleController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: notrController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (titleController.text != "" || notrController.text != "") {
      DatabaseHelper.instance.add(SimpleModel(
          name: titleController.text, description: notrController.text));
    }
    Navigator.pop(context);
    return false;
  }
}
