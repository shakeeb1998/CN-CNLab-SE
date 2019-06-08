import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:on_day/cn/cnhomescreen.dart';
import 'package:on_day/SString.dart';
import 'package:on_day/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


///Splash
///login
///send request
///accept request
///location



///distance calculations
///ui improvemnts
///alerts
///
class CNSplash extends StatefulWidget {
  @override
  _CNSplashState createState() => _CNSplashState();
}

class _CNSplashState extends State<CNSplash> {
  StatefulWidget retScreen;
  @override
  Widget build(BuildContext context) {
    print("shakeeb");
    print(context);
    return  Scaffold(
        body: new SplashScreen(
            imagePath: 'assets/logo1.jpg',
            home: retScreen,
            duringSplash: ()=>duringSplash(context),
            duration: 1500),

    );
  }


  duringSplash(BuildContext context1)
  async {
    await Future.delayed(const Duration(seconds: 2), () => "1");
   SharedPreferences preferences= await SharedPreferences.getInstance();
   String uid=preferences.getString(CnString.uid);
   if(uid != null)
     {
       print("help");
       Navigator.of(context1).pushReplacement(
           MaterialPageRoute(builder: ( context1) => CNHome(
             preferences: preferences,
             uid: uid,email:preferences.getString(CnString.email),photo: preferences.getString(CnString.photourl),name:preferences.getString(CnString.name),)));
     }
     else
       {
         print(context);

         print("death");
         Navigator.of(context1).pushReplacement(
             MaterialPageRoute(builder: ( context1) => FireBaseLogin(app: null,)));
       }


  }

}
