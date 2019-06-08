import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import '../SString.dart';
import 'distance_widget.dart';

import 'package:url_launcher/url_launcher.dart';
class CNHomeScreenCard extends StatefulWidget {
  StreamSubscription<Position> positionStream;
  ValueNotifier<Position>val;
  String frenUid;
  CNHomeScreenCard({this.frenUid,this.positionStream,this.val}
  ){
   print("dzd ${frenUid}");
  }
  @override
  _CNHomeScreenCardState createState() => _CNHomeScreenCardState();
}

class _CNHomeScreenCardState extends State<CNHomeScreenCard> {
  var geolocator;
  bool alertSwitchstate;
  @override
  void initState() {
    print('dd');
    // TODO: implement initState
    super.initState();


    widget.val.addListener((){

    });


  }

  @override
  Widget build(BuildContext context) {
    print(widget.frenUid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance.collection(CnString.fusercollectiom).document(widget.frenUid).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return new Text('Loading...');
                        default:
                          return new ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(snapshot.data[CnString.photourl].toString()),
                              backgroundColor: Colors.transparent,
                            ),
                            title: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(snapshot.data[CnString.name]),

                                new Padding(padding: EdgeInsets.only(top:8.0),
                                child:(snapshot.data[CnString.number] != null)?new Align(alignment: Alignment.centerLeft, child: Text(snapshot.data[CnString.number]),):new Align(alignment: Alignment.centerLeft, child: Text(CnString.noNotavailable),),
                                ),
                                new Padding(padding: EdgeInsets.only(top:8.0),

                              child:new Text(CnString.lastKnownlocation),

                              ),
                                new Padding(padding: EdgeInsets.only(top:8.0),

                                  child:Place(p: new Position(latitude:snapshot.data[CnString.lat] ,longitude: snapshot.data[CnString.lng]),),

                                ),

                                new Padding(padding: EdgeInsets.only(top:8.0),

                                  child:new Text(CnString.coordinates),

                                ),
                               new InkWell(
                                 onTap: () async {
                                   String url = "https://maps.google.com/maps/search/?api=1&q=loc:${snapshot.data[CnString.lat] },${snapshot.data[CnString.lng] }";
                                    print(await canLaunch(url));
                                    launch(url);
                                 },
                                 child:  new Column(
                                   children: <Widget>[
                                     new Padding(padding: EdgeInsets.only(top:8.0),

                                       child:new Text("${CnString.lat}  ${snapshot.data[CnString.lat] }"),

                                     ),
                                     new Padding(padding: EdgeInsets.only(top:8.0),

                                       child:new Text("${CnString.lng}  ${snapshot.data[CnString.lng] }"),
                                     ),
                                   ],
                                 ),
                               ),
                                new Divider(color: Colors.black,),
                                new Row(
                                  children: <Widget>[
                                    new Padding(padding: EdgeInsets.only(top:8.0),

                                      child:new Text(CnString.distance+" "),

                                    ),
                                   new Flexible(child: DistanceFinder(startLatitude: (widget.val.value!=null)?widget.val.value.latitude:0.0,startLongitude: (widget.val.value!=null)?widget.val.value.longitude:0.0,endLatitude: snapshot.data[CnString.lat],endLongitude: snapshot.data[CnString.lng],valueNotifier: widget.val,uid: snapshot.data[CnString.uid],))
                                  ],
                                ),

                               new Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   new Padding(padding: EdgeInsets.only(top:8.0),

                                     child:new Text(CnString.alerts),

                                   ),
                                   new AlertToggle(uid: snapshot.data[CnString.uid],)
                                 ],
                               ),




                              ],
                            ),
                      );
                      }
                    },
                  ),
            ),


          ),
        ],
      ),
    );
  }
  work()
  {

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0);
//
//    StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).(
//            (Position position) {
//          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
//        });
  }
}