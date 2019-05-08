import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:on_day/OnDay/Final Results.dart';
class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Results'),),
      body: new Center(
        child: new Clist(),
      ),
    );
  }
}

class Clist extends StatefulWidget {
  @override
  _ClistState createState() => _ClistState();
}

class _ClistState extends State<Clist> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('results').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new CCard(document: document,);
              }).toList(),
            );
        }
      },
    );
  }
}
class CCard extends StatefulWidget {
  DocumentSnapshot document;
  CCard({this.document});
  @override
  _CCardState createState() => _CCardState();
}

class _CCardState extends State<CCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(

        child: InkWell(
          onTap: ()=>pres(widget.document,context),
          child: Column(
            children: <Widget>[
              new Text("${widget.document['comp']}",
                style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w700),


              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Container(height: 8.0,color: Colors.black,),
              ),
              new Text('RUNNERS UP',
                style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w700),

              ),

              new Text("${widget.document['runner']}",
                  style: TextStyle(fontSize: 21.0),

        ),
              new Text("${widget.document['ru']}",
                style: TextStyle(fontSize: 21.0),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Container(height: 8.0,color: Colors.black,),
              ),
              new Text('WINNER',
                style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w700),

              ),

              new Text("${widget.document['winner']}",
                style: TextStyle(fontSize: 21.0),

              ),
              new Text("${widget.document['wu']}",
                style: TextStyle(fontSize: 21.0),

              ),



            ],
          ),
        ),
      ),
    );
  }
  pres(DocumentSnapshot document,BuildContext context)
  async {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new President(ds: document,)));
  }
  Future<void> alert3(BuildContext context,DocumentSnapshot document) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Text('${widget.document['comp']}'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new TextFormField(),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(),
              ),
            ],
          ),
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
class DialogExample extends StatefulWidget {

  @override
  _DialogExampleState createState() => new _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  String _text = "initial";
  TextEditingController _c;
  @override
  initState(){
    _c = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_text),
              new RaisedButton(onPressed: () {
                showDialog(child: new Dialog(
                  child: new Column(
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(hintText: "Update Info"),
                        controller: _c,

                      ),
                      new FlatButton(
                        child: new Text("Save"),
                        onPressed: (){
                          setState((){
                            this._text = _c.text;
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),

                ), context: context);
              },child: new Text("Show Dialog"),)
            ],
          )
      ),
    );
  }
}
