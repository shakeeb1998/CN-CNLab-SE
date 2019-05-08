import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/common/login.dart';
import 'package:on_day/se/se_resturant/returants_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../SString.dart';
import 'dart:io';
import 'dart:convert';
class RESplash extends StatefulWidget {
  @override
  _RESplashState createState() => _RESplashState();
}

class _RESplashState extends State<RESplash> {
  var retScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
          imagePath: 'assets/logo.png',
          home: retScreen,
          duringSplash: ()=>duringSplash(),
          duration: 1500),
    );
  }
  duringSplash()
  async {

    SharedPreferences preferences= await SharedPreferences.getInstance();
    String uid=preferences.getString(CnString.uid);
    await Future.delayed(const Duration(seconds: 2), () => "1");

    if(uid!=null && preferences.getString(CnString.restID)!=null)
    {
      String str=preferences.getString("doc");
      var map=json.decode(str);
      print(map[ModelResturants.name]);

      print("help");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => ResturantHomeScreen(map: map,preferences: preferences,)));
    }
else
    {
      print("death");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '3',)));
    }


  }

}
