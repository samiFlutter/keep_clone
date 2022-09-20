import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/label_model.dart';
import '../service/my_databasehelper.dart';

class NewLabelScreen extends StatefulWidget {
  const NewLabelScreen({Key? key}) : super(key: key);

  @override
  State<NewLabelScreen> createState() => _NewLabelScreenState();
}

class _NewLabelScreenState extends State<NewLabelScreen> {
  FocusNode myFocusNode = FocusNode();
  int? selectedId;
  bool addNewLabelSelected = false;

  var addNewLabelIcon = Icons.add;
  Color bgcolor = Colors.white;
  var newLabelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: bgcolor,
        elevation: 0,
        title: Text(
          'Edit labels',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<LabelModel>>(
        future: DatabaseHelper.instance.getLabelModels(),
        builder:
            (BuildContext context, AsyncSnapshot<List<LabelModel>> snapshot) {
          return snapshot.data == null
              ? Container(
                  child: Text('snapshot null'),
                )
              : snapshot.data!.isEmpty
                  ? Column(
                      children: upList(),
                    )
                  : ListView(
                      children: upList() +
                          snapshot.data!.map((label) {
                            return Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    color: selectedId == label.id
                                        ? Colors.amber
                                        : Colors.white,
                                    child: ListTile(
                                      leading: Icon(Icons.label_outline),
                                      title: Text(label.name),
                                      onTap: () => {},
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    );
        },
      ),
    );
  }

  Widget my_inputBorder() {
    return addNewLabelSelected
        ? Divider(
            height: 1,
          )
        : Container(
            height: 1,
          );
  }

  List<Widget> upList() {
    return <Widget>[
      my_inputBorder(),
      Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  addNewLabelSelected = !addNewLabelSelected;
                  addNewLabelIcon = !addNewLabelSelected
                      ? Icons.add
                      : CupertinoIcons.multiply;
                });

                myFocusNode.requestFocus();
              },
              icon: Icon(
                addNewLabelIcon,
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: newLabelController,
                //autofocus: true,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Create new label",
                ),
              )),
          IconButton(
              onPressed: () {
                newLabelController.text.isEmpty
                    ? {}
                    : DatabaseHelper.instance
                        .addLabel(LabelModel(name: newLabelController.text));
              },
              icon: Icon(
                Icons.check,
              )),
        ],
      ),
      my_inputBorder(),
    ];
  }
}
