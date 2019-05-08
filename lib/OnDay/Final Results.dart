import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class President extends StatefulWidget {
  DocumentSnapshot ds;
  President({this.ds});
  @override
  _PresidentState createState() => _PresidentState();
}

class _PresidentState extends State<President> {
  final formKey = GlobalKey<FormState>();
  String winner='';
  String runner='';
  String wu='';
  String ru='';
  TextEditingController controller;
  TextEditingController c1;
  TextEditingController c2;
  TextEditingController c3;

  @override
  Widget build(BuildContext context) {
    controller=new TextEditingController(text: widget.ds['winner'].toString());
    c1=new TextEditingController(text: widget.ds['runner'].toString());
    c2=new TextEditingController(text: widget.ds['wu'].toString());
    c3=new TextEditingController(text: widget.ds['ru'].toString());


    return Scaffold(
      appBar: new AppBar(title: new Text('Edit Results'),),

      body:Form(
        key: formKey,
        child: new ListView(
        shrinkWrap: true,
          children: <Widget>[
            Text('${widget.ds['comp']}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                onSaved: (val)=>savWin(val),
                validator: (val)=>runnerName(val),

                decoration: InputDecoration(labelText:'Winners ',border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)) ),

                controller: controller,


              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                onSaved: (val)=>saveWU(val),
                validator: (val)=>runnerName(val),

                decoration: InputDecoration(labelText:'Winners uni',border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)) ),

                controller: c2,


              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                onSaved: (val)=>savRun(val),

                validator: (val)=>runnerName(val),
                controller: c1,
                decoration: InputDecoration(labelText:'Runners Up',border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)) ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                onSaved: (val)=>saveRU(val),
                validator: (val)=>runnerName(val),

                decoration: InputDecoration(labelText:'Winners uni',border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)) ),

                controller: c3,


              ),
            ),
            new RaisedButton(onPressed:()=> pressed(),child: new Text('Submit'),)
          ],
        ),
      ),
      
    );
  }
  saveWU(String val)
  {
    wu=val;
  }
  saveRU(String val)
  {
    ru=val;
  }
  pressed()
  async {
    if(formKey.currentState.validate())
        {
          formKey.currentState.save();
          await Firestore.instance.collection('results').document(widget.ds['id']).updateData(
            {
              'winner':winner,
              'runner':runner,
              'ru':ru,
              'wu':wu

            }
          );
          Navigator.pop(context);

        }
        
  }
  savWin(String val)
  {
    winner=val;
  }
  savRun(String val)
  {
    runner=val;
  }


  runnerName(String val)
  {
    if(val.length==0 || val==null)
    {
      return "Field Cant be empty";
    }
    else
    {
      return null;
    }
  }

}
