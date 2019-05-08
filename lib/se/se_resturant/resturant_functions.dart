import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_day/common/login.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item_adder.dart';



addItemToCuisine({@required DocumentSnapshot documentsnap,@required var map,@required int currentIndex,@required BuildContext context,@required SharedPreferences prefs})
{
  Navigator.of(context).push(
      CupertinoPageRoute(builder: (BuildContext context) => ItemAdder(map: map,currentIndex: currentIndex,context: context,documentsnap: documentsnap,sharedPreferences: prefs,)));

}

