import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_day/OnDay/sortedatt.dart';

class Clister extends StatefulWidget {
  @override
  _ClisterState createState() => _ClisterState();
}

class _ClisterState extends State<Clister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("ALL COMPS"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('competitions').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return CCard(ds: document,) ;
                }).toList(),
              );
          }
        },
      ),
      
    );
  }
}
class CCard extends StatefulWidget {
  DocumentSnapshot ds;
  CCard({this.ds});
  @override
  _CCardState createState() => _CCardState();
}

class _CCardState extends State<CCard> {
  pressed()
  {
    print('check');
    print(widget.ds['competition_id']);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new sortAtt(name: widget.ds['competition_name'].toString(),id:widget.ds['competition_id'].toString() ,)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>pressed(),
      child: ListTile(title: new Text(widget.ds['competition_name'].toString(),),
      subtitle: new Divider(),
      ),
    );
  }
}
