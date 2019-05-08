import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:qr_reader/qr_reader.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  TextEditingController controller= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(

            child: new RaisedButton(onPressed:()=>scane() ,child: new Text('scan'),),

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new TextFormField(
              controller: controller,
              style: TextStyle(),decoration: InputDecoration(labelText: "Enter Team Code",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
          ),
          new RaisedButton(onPressed:()=>submit() ,child: new Text('Submit'),),

        ],
      ),
    );
  }
  submit()
  {
    getDetails(controller.text);

  }

  scane()
  async {
    String futureString = await new QRCodeReader()
        .setAutoFocusIntervalInMs(200) // default 5000
        .setForceAutoFocus(true) // default false
        .setTorchEnabled(false) // default false
        .setHandlePermissions(true) // default true
        .setExecuteAfterPermissionGranted(true) // default true
        .scan();
    print('scanned item is ${futureString}');
    getDetails(futureString);
  }


  Future<void> alert4(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Invalid Code'),
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
  getDetails(String code)
  async {
    QuerySnapshot x =await Firestore.instance.collection('TAtt').where("team_code",isEqualTo: code.toUpperCase()).getDocuments();

    //Todo
    //whenn res empty

    if(x.documents.length==0)
    {
      await alert4(context);
    }
    else
    {
      DocumentSnapshot a=x.documents[0];

      print('rees ${a.data}');


      var bb=await Firestore.instance.collection('CompAtt').where('team_code',isEqualTo: a.data['team_code']).limit(1).getDocuments();
      print('sdd');
      print(bb.documents);
      if(bb.documents.length>0)
      {
        for(var i in bb.documents)
        {
          print('dcv');
          print(i.data);
        }
        print('ids given');
        await alert3(context);
      }
      else
      {
        {
          print('give id');
          await ackAlert(context,a.data);
        }
      }
    }

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
              child: Text('Mark Attendance'),
              onPressed: () async {
                await markAttendance(a);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
  markAttendance(var a)
  async {
    await Firestore.instance.collection('CompAtt').add({
      "members":a["members"],
      'team_name':a['team_name'],
      'team_code':a['team_code'],
      'competition':a['competition'],
      'competition_id':a['competition_id'],
      'institute':a['institute']



    });
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

    l.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text('Members'),
    ));

    for (var i in a['membersj'])
    {
      l.add(new Text(i.toString()));
    }


    return l;
  }
  Future<void> alert2(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Payment not verified'),
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
  Future<void> alert3(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Already Marked'),
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


