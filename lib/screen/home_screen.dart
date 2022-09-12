import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:keep_clone/service/items_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ItemsService itemsService = ItemsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("keep clone ")),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.autorenew),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: itemsService.listItems,
      ),
    );
  }
}
