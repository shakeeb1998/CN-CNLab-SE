import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class SocketTest extends StatefulWidget {
  String email,uid;

  SocketTest({this.uid,this.email});

  @override
  _SocketTestState createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  var col=Colors.red;
  static const platform = const MethodChannel(
      'music');
  _SocketTestState(){
    platform.setMethodCallHandler(_handleMethod);

  }
  Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("sdxds");

    Socket.connect('192.168.43.91'   , 8002  ).then((Socket sock) {
      print("connected to socket");
      setState(() {
        col=Colors.blue;
      });
     socket= sock;
     socket.write("connected by ${widget.email}");
      socket.listen((data)=>dataHandler(data),);




    });

  }
  void dataHandler(data){
    print('dzkkjdn'); 
    print(new String.fromCharCodes(data).trim());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("test"),),
      body: new Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.check_circle,size: 200.0,color: col,)
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> _handleMethod(MethodCall call) async {
    print("method");
    print("kollin");
    print(call.method);
    socket.close();
    setState(() {
      col=Colors.red;
    });
    switch(call.method) {
      case "message":
        debugPrint(call.arguments);
        return new Future.value("");
    }
  }
}
//172.26.12.249