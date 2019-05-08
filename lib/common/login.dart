import 'package:flutter/material.dart';
import 'package:on_day/SString.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
class FireBaseLogin extends StatefulWidget {
  String app;
  FireBaseLogin({this.app});
  @override
  _FireBaseLoginState createState() => _FireBaseLoginState();
}

class _FireBaseLoginState extends State<FireBaseLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(SString.cnlLablogin),backgroundColor: Colors.pink,),
      body: Builder(builder: (BuildContext context) {
        BuildContext scaffoldContext=context;

        return Split(app: widget.app,scaffoldContext: scaffoldContext,);}),
    );
  }
}
class Split extends StatefulWidget {
  BuildContext scaffoldContext;
  String app;
  Split({this.app,this.scaffoldContext});
  @override
  _SplitState createState() => _SplitState();
}

class _SplitState extends State<Split> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Center(
          child: new GoogleSignInButton(

            onPressed: () =>cnLogin(context,app: widget.app,scaffold: widget.scaffoldContext),
            darkMode: false, // default: false
          ),
        ),

        Center(
          child: FacebookSignInButton(onPressed: () {
            // call authentication logic
          }),
        ),

        Center(child: new RaisedButton(onPressed: ()=>cnLogout(),child: new Text('Log Out'),),)
      ],
    );
  }
}

