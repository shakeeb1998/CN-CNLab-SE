import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_day/SString.dart';
import '../Orders.dart';
class RestOrders extends StatefulWidget {
  SharedPreferences sharedPreferences;
  RestOrders({this.sharedPreferences});
  @override
  _RestOrdersState createState() => _RestOrdersState();
}

class _RestOrdersState extends State<RestOrders> {
  @override
  Widget build(BuildContext context) {
    return Orders(sharedPreferences: widget.sharedPreferences,resturantOrderref: '${ModelResturants.modelName}/${widget.sharedPreferences.getString(CnString.restID)}',);
  }
}
