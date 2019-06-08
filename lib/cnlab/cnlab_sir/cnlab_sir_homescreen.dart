import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
import 'package:on_day/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:on_day/SString.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CNLSHomeScreen extends StatefulWidget {
  SharedPreferences preferences;
  CNLSHomeScreen({this.preferences});

  @override
  _CNLSHomeScreenState createState() => _CNLSHomeScreenState();
}

class _CNLSHomeScreenState extends State<CNLSHomeScreen> {
  StreamController startStopcontroller;
  Future fetchUser() {
     Dio().get(Apis.getTeacherClass+widget.preferences.getString(CnLab.muid)).then((resp){

       print("he;lp");
       startStopcontroller.add(resp.data);
    });


  }
  @override
  void initState() {
    startStopcontroller=new StreamController();
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 5), (_) => fetchUser());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        child: new ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(widget.preferences.getString(CnString.name)),
              accountEmail: new Text(widget.preferences.getString(CnString.email)),
              currentAccountPicture: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.preferences.getString(CnString.photourl)),),
            ),
            new ListTile(leading: new Icon(Icons.exit_to_app),title: new Text('logout'),onTap: (){
              cnLogout();
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '1',)));
            },),
          ],
        ),
      ),
      appBar: new AppBar(title: new Text('My Classes'),),
      body: new StreamBuilder(
          stream: startStopcontroller.stream,
          builder: ( BuildContext context, AsyncSnapshot<dynamic>snapshot){

            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return new Text("loading");
              }
              else{
                return new ListBuilder(map:snapshot.data,);
            }

          }),

    );
  }
}

class ClassCard extends StatefulWidget {
  var snapshot;
  var courseSnapshot;

  ClassCard({this.snapshot,this.courseSnapshot});
  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text("Class"),
                    new Text("${widget.snapshot['name']}")
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClassStatus(map: widget.snapshot,courseSnapshot: widget.courseSnapshot,)
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: new RaisedButton(onPressed: (!widget.snapshot.data[CnLab.start])?()=>start():null,child: new Text('Start',style: TextStyle(color: Colors.white),),color: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: new RaisedButton(onPressed:(widget.snapshot.data[CnLab.start])? (){}:null,child: new Text("Stop",style: TextStyle(color: Colors.white)),color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
//                    )
                  ],
                )
              ],
            ),
          ],
        ),

      ),
    );
  }
  start()
  {
    _showDialog();
  }
  void _showDialog({bool d}) {
    Widget a=new CircularProgressIndicator();
    // flutter defined function
    bool b=(d==null)?true:d;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        Future.delayed(const Duration(seconds: 2), (){
          setState(() {
            a=new Text("shaka");
            b=false;
            print('help me out');
            Navigator.pop(context);
            _showDialog(d: b);
          });
        });
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: Content(b: b,),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
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


class Content extends StatefulWidget {
  bool b;
  Content({this.b});
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Widget a=new CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return (widget.b)?a:new Text('qowjwjw');
  }
}
class ListBuilder extends StatefulWidget {
  var map;
  var courseSnapshot;
  ListBuilder({this.map,this.courseSnapshot});
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    List <Widget>a =[];

    for(var i in widget.map)
    {

      a.add(ClassCard(snapshot: i,courseSnapshot: widget.courseSnapshot,));
    }
    return ListView(children: a);;
  }
}
class ClassStatus extends StatefulWidget {

  var courseSnapshot;

  String id;
  var map;
  ClassStatus({this.map,this.courseSnapshot});
  @override
  _ClassStatusState createState() => _ClassStatusState();
}

class _ClassStatusState extends State<ClassStatus> {
  StreamController streamController;
  fetchCourseStatus(){
    Dio().get(Apis.baseUrl+'course/ongoing/'+widget.map['_id']).then((resp){
      streamController.add(resp.data);
      print(resp.data);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController=new StreamController();
    fetchCourseStatus();
    Timer.periodic(Duration(seconds: 5), (_) => fetchCourseStatus());


  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamController.stream,
        builder: ( context , snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return new Text("loading");
          }
          else{
            return               new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new RaisedButton(onPressed: (!snapshot.data[CnLab.start])?

                          (){
                        print(Apis.baseUrl+Apis.class1+'start');
                        Dio().post(Apis.baseUrl+Apis.class1+'start',data: {
                          "course_id":widget.map[CnLab.muid],
                        }).then((resp){
                        });

                      }:null,child: new Text('Start',style: TextStyle(color: Colors.white),),color: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new RaisedButton(onPressed:(snapshot.data[CnLab.start])?
                          (){
                            Dio().post(Apis.baseUrl+Apis.class1+'end',data: {
                              "course_id":widget.map[CnLab.muid],
                            }).then((resp){
                              print(resp.data);
                            });

                      }:null,child: new Text("Stop",style: TextStyle(color: Colors.white)),color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                    )
              ],
            );


          }
        });
  }
  joinClass(){

  }
}
