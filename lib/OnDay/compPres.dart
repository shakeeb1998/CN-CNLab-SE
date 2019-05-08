
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Present extends StatefulWidget {
  String id;
  Present({this.id});
  @override
  _PresentState createState() => _PresentState();
}

class _PresentState extends State<Present> {
  @override
  Widget build(BuildContext context) {
    print('id is ${widget.id}');
    return  StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('CompAtt').where('competition',isEqualTo: widget.id  ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new CCard(d: document,);
              }).toList(),
            );
        }
      },
    );;
  }
}

class CCard extends StatefulWidget {
  DocumentSnapshot d;
  CCard({this.d});
  @override
  _CCardState createState() => _CCardState();
}

class _CCardState extends State<CCard> {
  tapped(DocumentSnapshot d) async {
    var a = await Firestore.instance.collection('CompAtt').where('team_code',isEqualTo: d['team_code'].toString()).getDocuments();
    var b=a.documents;
    for (var i in b)
      {
        var d=await Firestore.instance.collection("CompAtt").document(i.documentID).get();
        if(d['color'].toString()=='q')
          {
            var d=await Firestore.instance.collection("CompAtt").document(i.documentID).updateData(
              {
                'color':'a'
              }
            );

          }
          else
            {
              var d=await Firestore.instance.collection("CompAtt").document(i.documentID).updateData(
                  {
                    'color':'q'
                  }
              );
            }
      }

  }
  List<Widget>listBuilder(var a)
  {
    List <Widget>l=List();

    l.add(new Text("Team Name"));
    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(a["team_name"].toString()),
    ));
    l.add(new Text("Competition"));
    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(a["competition"].toString()),
    ));
    l.add(new Text('Team Code'));
    l.add(new Text(a['team_code']));

    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text('Members'),
    ));

    for (var i in a['members'])
    {
      l.add(new Text(i.toString()));
    }


    return l;
  }
  Future<void> ackAlert(BuildContext context,var a) {
    Widget widget= new ListView(
      shrinkWrap: true,
//      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
      children:listBuilder(a),
    );
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: widget ,
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
  pressed(DocumentSnapshot d)
  {
    ackAlert(context, d);


  }
  @override
  Widget build(BuildContext context) {
    print('color');
    print(widget.d['color']);
    return Card(
        color: (widget.d['color'].toString()=='q')?Colors.green:Colors.white,
        child: Container(child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                  onTap: ()=>tapped(widget.d),
                  child: new Icon(Icons.add)),
            ),
            Expanded(
              child: InkWell(
                onTap: ()=>pressed(widget.d),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
      children: <Widget>[
                new Text('${widget.d['team_name']}'),
                new Text('${widget.d['institute']}'),
                new Text('${widget.d['team_code']}'),

      ],
    ),
              ),
            ),
          ],
        ),));
  }
}
