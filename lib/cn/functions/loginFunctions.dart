import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:on_day/cnlab/cnlab_sir/cnlab_sir_homescreen.dart';
import 'package:on_day/cnlab/cnlab_student_homescreen.dart';
import 'package:on_day/cnlab/socketTest.dart';
import 'package:on_day/se/se_home_screen.dart';
import 'package:on_day/se/se_resturant/returants_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_day/SString.dart';
import 'dart:convert';
import '../cnhomescreen.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_day/SString.dart';

import 'api_calls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

cnLogin(BuildContext context,
    {String app, BuildContext scaffold = null}) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  print("app no ${app}");
  final FirebaseUser user = await _auth.signInWithCredential(credential);
  await cnSaveTolocal(user);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure();
  _firebaseMessaging.getToken().then((token) {
    enterUserdata(
        email: user.email,
        name: user.displayName,
        uid: user.uid,
        fcm_id: token);
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (app == null) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (BuildContext context) => CNHome(
              preferences: preferences,
              uid: user.uid,
              email: user.email,
              name: user.displayName,
              photo: user.photoUrl,
            )));
  } else if (app == "1") {
//      File image=await ImagePicker.pickImage(source: ImageSource.camera);
//      List<int> imageBytes = image.readAsBytesSync();
//      print(imageBytes);
//      String base64Image = base64Encode(imageBytes);

    Dio().post(Apis.baseUrl + Apis.student, data: {
      CnString.name: preferences.getString(CnString.name),
      CnString.email: preferences.getString(CnString.email),
    }).then((resp) {
      print(resp.data);

      Dio()
          .get(Apis.baseUrl +
              Apis.student +
              preferences.getString(CnString.email))
          .then((resp2) {
        print(resp2.data);

        preferences.setString(CnLab.muid, resp2.data[CnLab.muid]);

        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => CNLabHome(
                  preferences: preferences,
                )));
      });
    });
  } else if (app == "2") {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (BuildContext context) => SEHomeScreen(
              sharedPreferences: preferences,
            )));
  } else if (app == "3") {
    print("checker");
    _showDialog(context, preferences, scaffold: scaffold);
  } else if (app == '4') {
    //todo add the api call here
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (BuildContext context) => SEHomeScreen(
              sharedPreferences: preferences,
            )));
  }
}

void _showDialog(BuildContext context, SharedPreferences preferences,
    {BuildContext scaffold}) {
  // flutter defined function
  bool placing = true;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Firestore.instance
            .collection('resturants')
            .where(ModelResturants.ownerEmail,
                isEqualTo: preferences.getString(CnString.email))
            .getDocuments()
            .then((querySnapshot) {
          var a = querySnapshot.documents;
          if (a.length > 0) {
            Navigator.pop(context);
            var b = a[0];
            preferences.setString(CnString.restID, b.documentID);
            preferences.setString("doc", json.encode(b.data));

            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (BuildContext context) =>
                    ResturantHomeScreen(documentSnapshot: b)));
          } else {
            print('context');
            print(scaffold);
            Navigator.pop(context);
            Scaffold.of(scaffold).showSnackBar(SnackBar(
              content:
                  Text('You have no resturant contact admin contact admin'),
              duration: Duration(seconds: 3),
            ));
          }
        });
        ;

        return AlertDialog(
          title: new Text("Checking Validity"),
          content: (placing)
              ? Row(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        new CircularProgressIndicator(),
                      ],
                    ),
                  ],
                )
              : new Text('Order Placed'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

cnSaveTolocal(FirebaseUser user) async {
//  #
//  Todo some vars might be null
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(CnString.email, user.email);
  await prefs.setString(CnString.name, user.displayName);
  await prefs.setString(CnString.number, user.phoneNumber);
  await prefs.setString(CnString.photourl, user.photoUrl);
  await prefs.setString(CnString.uid, user.uid);
  print("Deets Saved Locally");
  await Firestore.instance
      .collection(CnString.fusercollectiom)
      .document(user.uid)
      .setData(
    {
      CnString.email: user.email,
      CnString.name: user.displayName,
      CnString.number: user.phoneNumber,
      CnString.photourl: user.photoUrl,
      CnString.uid: user.uid,
    },
    merge: true,
  );
  print('done');
}

cnLogout() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
