  import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
import 'package:on_day/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../SString.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'socketTest.dart';
class CNLabHome extends StatefulWidget {
  SharedPreferences preferences;
  CNLabHome({this.preferences});
  
  @override
  _CNLabHomeState createState() => _CNLabHomeState();
}

class _CNLabHomeState extends State<CNLabHome> {
  StreamController streamController;
  
  fetchClasses(){
    print(Apis.getStudentclass+widget.preferences.getString(CnLab.muid));

    Dio().get(Apis.getStudentclass+widget.preferences.getString(CnLab.muid)).then((resp){
      print(Apis.getStudentclass+widget.preferences.getString(CnLab.muid));
      streamController.add(resp.data);
    });
    
  }
  @override
  void initState() {
    streamController=new StreamController();
    // TODO: implement initState
    super.initState();
    print(Apis.getStudentclass+widget.preferences.getString(CnLab.muid));

    fetchClasses();
    Timer.periodic(Duration(seconds: 5), (_) => fetchClasses());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Student Classes"),),
      drawer: Drawer(
        child: ListView(
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
      body:new StreamBuilder(
          stream: streamController.stream,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return new Text("loading");
              }
              else
                {

                  return ListBuilder(snapshot: snapshot,preferences: widget.preferences,);
                }
      }),
    );
  }
}
class ListBuilder extends StatefulWidget {
  var snapshot;
  SharedPreferences preferences;

  ListBuilder({this.snapshot,this.preferences});
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    List <Widget>a =[];

    for(var i in widget.snapshot.data)
      {
        a.add(StudentClassCard(map: i,preferences: widget.preferences,));
      }
    return ListView(children: a);
  }
}

class StudentClassCard extends StatefulWidget {
  SharedPreferences preferences;

  var map;
  StudentClassCard({this.map,this.preferences});
  @override
  _StudentClassCardState createState() => _StudentClassCardState();
}

class _StudentClassCardState extends State<StudentClassCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Class ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                new AutoSizeText("${widget.map['course']['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.blue),maxLines: 1,),
              ],
            ),
          ),

          ClassStatus(map: widget.map,preferences: widget.preferences,),
        ],
      ),
    );
  }
}
class ClassStatus extends StatefulWidget {

  SharedPreferences preferences;

  String id;
  var map;
  ClassStatus({this.map,this.preferences});
  @override
  _ClassStatusState createState() => _ClassStatusState();
}

class _ClassStatusState extends State<ClassStatus> {
  StreamController streamController;
  fetchCourseStatus(){
    Dio().get(Apis.baseUrl+'course/ongoing/'+widget.map['course']['_id']).then((resp){
      streamController.add(resp.data);
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
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Status  ",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    (snapshot.data['on_going'])?new Text("going"):new Text("not started")
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: <Widget>[
                  new RaisedButton(onPressed: (snapshot.data['on_going'])?()=>joinClass():null,child: new Text("Join Class",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),color: Colors.green,),
                ],),
            )

          ],
        );
      }
    });
  }
  joinClass() async {
    print(widget.map);
          File image=await ImagePicker.pickImage(source: ImageSource.camera);
      List<int> imageBytes = image.readAsBytesSync();
      print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      if(image==null)
        {
          print("shakku");

        }
        else{
          print("jj");
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (BuildContext context) => SocketTest(preferences:widget.preferences ,uid: widget.preferences.getString(CnString.uid),email: widget.preferences.getString(CnString.email),courseName: widget.map['course']['name'],)));
          
      }

  }
}
