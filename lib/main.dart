import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:on_day/OnDay/pr.dart';
import 'package:on_day/OnDay/head.dart';
import 'package:on_day/OnDay/Final Results.dart';
import 'package:on_day/OnDay/shakeeb.dart';
import 'package:on_day/OnDay/tabs.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:on_day/se/resturant_view.dart';
import 'package:on_day/se/se_home_screen.dart';
import 'package:on_day/se/se_resturant/resturant_splash.dart';
import 'package:on_day/se/se_splash.dart';
import 'cn/splash.dart';
import 'cnlab/cn_lab-splash.dart';
import 'cnlab/cnlab_sir/cnlab_sir_splash.dart';
import 'cnlab/socketTest.dart';
import 'common/login.dart';
import 'cn/text_sender.dart';
import 'eWallet/home_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MaterialApp(
      home: CNSplash(),
    ),
  );
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Login'),),
      body: Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
                onPressed: () => signin(), child: new Text('sign in')),
            new RaisedButton(
                onPressed: () => logout(), child: new Text('logout')),
          ],
        ),
      ),
    );
  }

  signin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    QuerySnapshot cr = await Firestore.instance
        .collection('accounts')
        .where('email', isEqualTo: '${user.email}')
        .getDocuments();
    if (cr.documents.length > 0) {
      DocumentSnapshot a = cr.documents[0];

      var m = a.data;
      if (m['type'].toString() == 'head')
      {
        print("is head");
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new tabBarview(compName: a['comp'],id: a['compid'],)));
      } else if (m['type'].toString() == 'pr')
      {
        print("is pr");

        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Attendance()));
      }
      else if(m['type'].toString()=='shakeeb')
        {
          print("is shakeeb");


          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new Results()));

        }


      else if (m['type'].toString()=='president'){
        print('dsfs');
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new President()));
      }
    } else {
      alert3(context);
      print('use nu id');
    }

    print('done');
    return user;
  }

  logout() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    print("check ${await _googleSignIn.isSignedIn()}");
    await _googleSignIn.signOut();
    print('logged out');
  }
  Future<void> alert3(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Use valid ID'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {

                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
}
