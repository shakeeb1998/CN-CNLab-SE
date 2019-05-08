import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../SString.dart';
import 'accept_request_card.dart';


class CNAcceptRequests extends StatefulWidget {
  String uid;
  CNAcceptRequests({this.uid});
  @override
  _CNAcceptRequestsState createState() => _CNAcceptRequestsState();
}

class _CNAcceptRequestsState extends State<CNAcceptRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title:  new Text(CnString.requests),
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(CnString.fusercollectiom).document(widget.uid).collection(CnString.frequests).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(CnString.fusercollectiom);
          print(widget.uid);
          print(CnString.fusercollectiom);

          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return new CNAcceptRequestCard(documentSnapshot: document,uid: widget.uid,);
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
