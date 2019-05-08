import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class sortAtt extends StatefulWidget {
  String id;
  String name;
  sortAtt({this.id,this.name});
  @override
  _sortAttState createState() => _sortAttState();
}

class _sortAttState extends State<sortAtt> {
  @override
  Widget build(BuildContext context) {
    print('check2');
    print(widget.id);
    return Scaffold(
      appBar: new AppBar(title: new Text(widget.name),),
      body:  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('CompAtt').where('competition_id',isEqualTo:widget.id ).snapshots(),
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
  @override
  Widget build(BuildContext context) {
    print('color ${ widget.ds['color']}');
    return InkWell(
      onTap: ()=>ackAlert(context, widget.ds),
      child: Card(
        color: (widget.ds['color'].toString()=='q')?Colors.green:Colors.white,
        child: ListTile(

          title: new Text(widget.ds['team_name']),
          subtitle: new Divider(),
        ),
      ),
    );
  }
  List<Widget>listBuilder(var a)
  {

    print(a.data);
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
    l.add(new Text("Institute"));
    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(a["institute"].toString()),
    ));

    l.add(new Text("Team Code"));
    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(a["team_code"].toString()),
    ));

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
//      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
    shrinkWrap: true,
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
              child: Text('Ok'),
              onPressed: ()  {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
}
