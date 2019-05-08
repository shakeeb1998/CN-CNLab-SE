import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/cn/cnhomescreen.dart';
import 'package:on_day/common/login.dart';
import 'package:on_day/se/se_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SString.dart';

class SESPlash extends StatefulWidget {
  @override
  _SESPlashState createState() => _SESPlashState();
}

class _SESPlashState extends State<SESPlash> {
  @override
  Widget build(BuildContext context) {
    var retScreen;
    return Scaffold(
      body: new SplashScreen(
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

    if(uid!=null)
    {
      print("help");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => SEHomeScreen(sharedPreferences: preferences,)));
    }
    else
    {
      print("death");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '2',)));
    }

  }
}
