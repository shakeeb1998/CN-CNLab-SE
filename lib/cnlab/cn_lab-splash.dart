import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:on_day/cn/cnhomescreen.dart';
import 'package:on_day/SString.dart';
import 'package:on_day/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cnlab_student_homescreen.dart';
import 'socketTest.dart';
import 'package:image_picker/image_picker.dart';
class CNlabsplash extends StatefulWidget {
  @override
  _CNlabsplashState createState() => _CNlabsplashState();
}

class _CNlabsplashState extends State<CNlabsplash> {
  @override
  Widget build(BuildContext context) {
    var retScreen;
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
    await Future.delayed(const Duration(seconds: 2), () => "1");
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String uid=preferences.getString(CnString.uid);
    String email=preferences.getString(CnString.email);
    if(uid!=null)
    {
//      var a=ImagePicker();
//      File image=await ImagePicker.pickImage(source: ImageSource.camera);
//      List<int> imageBytes = image.readAsBytesSync();
//      print(imageBytes);
//      String base64Image = base64Encode(imageBytes);

      print("help");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => CNLabHome(preferences: preferences),));
    }
    else
    {
      print("death");
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '1',)));
    }


  }
}
