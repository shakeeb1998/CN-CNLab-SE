import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../SString.dart';

class CNAcceptRequestCard extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  String uid;
  CNAcceptRequestCard({this.documentSnapshot,this.uid});
  @override
  _CNAcceptRequestCardState createState() => _CNAcceptRequestCardState();
}

class _CNAcceptRequestCardState extends State<CNAcceptRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.centerRight,child: new RaisedButton(onPressed:()=> acceptRequest(),child: new Text("Accept"),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.centerRight,child: new RaisedButton(onPressed:()=> deleteRequest(),child: new Text("Reject"),)),
              ),
            ],
          )
        ],

      ),
    );
  }
  acceptRequest()
  async {
    Firestore.instance.collection(CnString.fusercollectiom).document(widget.uid).collection(CnString.frequests).document(widget.documentSnapshot[CnString.uid]).delete().then((v){print("delelted");});

        Firestore.instance.collection(CnString.fusercollectiom).document(widget.documentSnapshot[CnString.uid]).collection(CnString.ffrens).document(widget.uid).setData({CnString.uid:widget.uid}).then((v){print("friend added");});

  }

  deleteRequest()
  {
    Firestore.instance.collection(CnString.fusercollectiom).document(widget.uid).collection(CnString.frequests).document(widget.documentSnapshot[CnString.uid]).delete().then((v){print("delelted");});

  }

}
