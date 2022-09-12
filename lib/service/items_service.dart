import 'package:flutter/material.dart';
import 'package:keep_clone/model/item_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemsService {
  var listItems = <Widget>[
    for (int i = 0; i < 20; i++) const ItemModel(),
  ];

  

}
