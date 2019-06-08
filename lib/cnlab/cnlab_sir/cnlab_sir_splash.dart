import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_day/SString.dart';

import 'cnlab_sir_homescreen.dart';

class CNLSplash extends StatefulWidget {
  @override
  _CNLSplashState createState() => _CNLSplashState();
}

class _CNLSplashState extends State<CNLSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SplashScreen(
          imagePath: 'assets/logo.png',
          home: null,
          duringSplash: ()=>duringSplash(),
          duration: 1500),
    );
  }
  duringSplash() async {
    var preferences=await SharedPreferences.getInstance();
    String uid=preferences.getString(CnString.uid);
    await Future.delayed(const Duration(seconds: 2), () => "1");

    if(uid==null)
      {
        print("death");
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '4',)));
      }
      else{
      print("death");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => CNLSHomeScreen(preferences: preferences,)));

    }


  }
}
