import 'package:flutter/material.dart';
import 'package:qr_reader/qr_reader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CompHead extends StatefulWidget {
  String compname;
  String id;
  CompHead({this.compname,this.id});
  @override
  _CompHeadState createState() => _CompHeadState();
}

class _CompHeadState extends State<CompHead> {
  String saveWinner='';
  String winnerUni='';
  String saveRunner='';
  String runnerUni='';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,

          child: ListView(

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(child: new Text('Result ${widget.compname}')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved:(val)=> saveWin(val),
                validator: (val)=>winnerName(val),
                  style: TextStyle(),decoration: InputDecoration(labelText: "winner",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved:(val)=> saveWU(val),
                  validator: (val)=>winnerName(val),
                  style: TextStyle(),decoration: InputDecoration(labelText: "winner uni",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved:(val)=> saveRun(val),

                  validator: (val)=>runnerName(val),
                  style: TextStyle(),decoration: InputDecoration(labelText: "runners up",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved:(val)=> saveRU(val),

                  validator: (val)=>runnerName(val),
                  style: TextStyle(),decoration: InputDecoration(labelText: "runners up uni",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(onPressed: ()=>submitPressed(),child:new Text('Submit')),
              ),

            ],
          ),
        ),
      ),
    );
  }

  winnerName(String val)
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
  saveWin(String val)
  {
    saveWinner=val;
  }
  saveWU(String val)
  {
    winnerUni=val;
  }
  saveRU(String val)
  {
    runnerUni=val;
  }
  saveRun(String val)
  {
    saveRunner=val;
  }

  submitPressed()
  async {
    if(formKey.currentState.validate())
      {
        formKey.currentState.save();
        DocumentSnapshot dr=await Firestore.instance.collection('results').document('${widget.id}').get();
        if(dr.exists)
          {
            alert3(context);
          }
          else{
          Firestore.instance.collection('results').document('${widget.id}').setData({
            'comp':widget.compname,
            'id':widget.id,
            'winner':saveWinner,
            'runner':saveRunner,
            'wu':winnerUni,
            'ru':runnerUni,

          });
        }
      }
  }

  Future<void> alert3(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Already Marked Contact Execitive'),
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
