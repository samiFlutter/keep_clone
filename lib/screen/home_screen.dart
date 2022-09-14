import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:keep_clone/model/simple_model.dart';
import 'package:keep_clone/service/items_service.dart';
import 'package:keep_clone/service/my_databasehelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();
  int? selectedId;
  ItemsService itemsService = ItemsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: TextField(
          controller: textController,
        )),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.autorenew),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: FutureBuilder<List<SimpleModel>>(
          future: DatabaseHelper.instance.getSimpleModels(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SimpleModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('loading...'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('NO Groceries in list.'),
                  )
                : ListView(
                    children: snapshot.data!.map((grocery) {
                      return Center(
                        child: Card(
                          color: selectedId == grocery.id
                              ? Colors.amber
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (selectedId == null) {
                                  textController.text = grocery.name;
                                  selectedId = grocery.id;
                                } else {
                                  textController.text = "";
                                  selectedId = null;
                                }
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                DatabaseHelper.instance.remove(grocery.id!);
                              });
                            },
                            title: Text(grocery.name),
                          ),
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(2),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              onPressed: () async {
                selectedId != null
                    ? await DatabaseHelper.instance.update(
                        SimpleModel(id: selectedId, name: textController.text))
                    : await DatabaseHelper.instance.add(
                        SimpleModel(name: textController.text),
                      );
                setState(() {
                  textController.clear();
                  selectedId = null;
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
      // body: ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: itemsService.listItems,
      // ),
      bottomSheet: getFooter(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 40,
      decoration: BoxDecoration(
          //   boxShadow: [
          //   BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 3)
          // ],
          color: Colors.grey[300]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: size.width * 0.7,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.check_box,
                        size: 20,
                        //color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.brush,
                        size: 18,
                        //color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.mic_rounded,
                        size: 22,
                        //color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.photo,
                        size: 22,
                        //color: white.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
