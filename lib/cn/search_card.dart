import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SString.dart';

class CNSearchCard extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  CNSearchCard({this.documentSnapshot});
  @override
  _CNSearchCardState createState() => _CNSearchCardState();
}

class _CNSearchCardState extends State<CNSearchCard> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(widget.documentSnapshot[CnString.photourl].toString()),
                  backgroundColor: Colors.transparent,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(widget.documentSnapshot[CnString.name]),

                  new Text(widget.documentSnapshot[CnString.email]),

                  (widget.documentSnapshot[CnString.number]!=null)?new Text(widget.documentSnapshot[CnString.number]):new Text("Number not available"),


                ],
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment: Alignment.centerRight,child: new RaisedButton(onPressed:()=> addChild(widget.documentSnapshot[CnString.uid]),child: new Text("Add Child"),)),
        )
        ],
        
      ),
    );
  }
  addChild(String uid) async {
//    Todo add viewed

    SharedPreferences pr=await SharedPreferences.getInstance();

    String email=pr.getString(CnString.email);
    String name=pr.getString(CnString.name);
    String number=pr.getString(CnString.number);
    String photourl=pr.getString(CnString.photourl);
    String uid1=pr.getString(CnString.uid);



    Firestore.instance.collection(CnString.fusercollectiom).document(uid).collection(CnString.frequests).document(uid1).setData({

      CnString.email: email,
      CnString.name: name,
      CnString.number: number,
      CnString.photourl: photourl,
      CnString.uid: uid1,

    }).then((val){
      print("Request Sent");
    });

  }
}
