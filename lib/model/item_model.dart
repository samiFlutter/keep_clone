import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemModel extends StatefulWidget {
  const ItemModel({Key? key}) : super(key: key);

  @override
  State<ItemModel> createState() => _ItemModelState();
}

class _ItemModelState extends State<ItemModel> {
  @override
  Widget build(BuildContext context) {
    return 
      InkWell(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 100,
              //color: Colors.amberAccent,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )
    ;
  }
}
