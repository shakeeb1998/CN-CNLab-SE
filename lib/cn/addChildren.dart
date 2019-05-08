import 'package:flutter/material.dart';
import 'package:on_day/cn/search_card.dart';

import '../SString.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CNAddpeople extends StatefulWidget {
  @override
  _CNAddpeopleState createState() => _CNAddpeopleState();
}

class _CNAddpeopleState extends State<CNAddpeople> {
  Firestore firestore;
  TextEditingController controller;
  Widget st;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    st=new Container();
    controller= new TextEditingController();
    firestore=Firestore.instance;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(CnString.search),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(child: new TextField(controller:controller,decoration: InputDecoration(labelText: CnString.search,border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),)),
                new InkWell(
                  onTap: ()=>getChild(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search,size: 30.0,),
                  ),
                )
              ],

            ),

          ),
          Expanded(
            child: st,
          )
        ],
      ),
    );
  }
  getChild()
  {
    String email=controller.text;
    setState(() {
      st=StreamBuilder<QuerySnapshot>(
        stream: firestore.collection(CnString.fusercollectiom).where(CnString.email,isEqualTo: email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return new  CNSearchCard(documentSnapshot: document,);
                }).toList(),
              );
          }
        },
      );

    });
  }

}
