import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:on_day/eWallet/sign_up.dart';

import 'home_page.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class SignIn extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(72, 21, 88, 1),

      body: new Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 38,bottom: 15,left: 15,right: 15),
          child: new Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            color:  Color.fromRGBO(237, 237, 237, 1),
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                Center(child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: new Text('Sign In',style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 40,fontWeight: FontWeight.bold),),
                )
                ),

                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: new Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('+92',),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(keyboardType: TextInputType.number,),
                      )),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left:18.0,top: 44,right: 18),
                  child: Center(child: new Text("PIN",style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 16,fontWeight: FontWeight.normal),),),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new PinCodeTextField(
                          pinBoxWidth: 13,
                          pinBoxHeight: 13,
                          hideCharacter:false,
                          highlight: true,
                          highlightColor: Colors.deepPurple,
                          autofocus: true,
                          maxLength: 6,
                          maskCharacter: ".",


                        ),
                      ),
                    ),
                  ],
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: new RaisedButton(onPressed: (){
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(builder: (BuildContext context) =>WalletHome(),));
                      },color:Color.fromRGBO(72, 21, 88, 1) ,child: Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom: 12.0,right: 20,left: 20),
                        child: new Text("Sign In",style: TextStyle(color: Colors.white ,fontSize: 18),),
                      ),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),),
                    ),
                  ],
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(onTap: (){
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(builder: (BuildContext context) =>SignUp(),));
                      },child: new Text("Dont Have an account?",style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 16,fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:18.0,bottom: 36),
                      child: InkWell(onTap: (){
                      },child: new Text("Forgot Password",style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 16,fontWeight: FontWeight.bold),)),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
