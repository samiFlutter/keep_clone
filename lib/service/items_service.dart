import 'package:flutter/material.dart';

class ItemsService {
  var listItems = <Widget>[
    for (int i = 0; i < 20; i++)
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
      ),
  ];
}
