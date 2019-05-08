import 'package:flutter/material.dart';
import 'package:on_day/OnDay/head.dart';
import 'package:on_day/OnDay/compPres.dart';
import 'package:on_day/OnDay/compAtt.dart';
class tabBarview extends StatefulWidget {
  String compName;
  String id;

  tabBarview({this.compName,this.id});
  @override
  _tabBarviewState createState() => _tabBarviewState();
}

class _tabBarviewState extends State<tabBarview> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: new AppBar(title: new Text(widget.compName),
        bottom: new TabBar(tabs: [
          new Tab(text: 'Attendance',),
          new Tab(text: 'Results',),
          new Tab(text: 'Present',)


        ]),),
        body: new TabBarView(children:
        [
          new Attendance(),
          new CompHead(compname: widget.compName,id: widget.compName),
          new Present(id: widget.compName,),


        ]
        ),
      ),
    );
  }
}
