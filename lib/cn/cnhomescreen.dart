import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:on_day/SString.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
import 'package:on_day/cn/text_sender.dart';
import 'package:on_day/common/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'accept_requests.dart';
import 'functions/api_calls.dart';
import 'functions/homefunctions.dart';
import 'home_screen_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CNHome extends StatefulWidget {
  String uid;
  String name;
  String email;
  SharedPreferences preferences;
  String photo;

  CNHome(
      {@required this.uid,
      @required this.email,
      @required this.name,
        @required this.preferences,
      @required this.photo});

  ValueNotifier pos;

  @override
  _CNHomeState createState() => _CNHomeState();
}

class _CNHomeState extends State<CNHome> {
  StreamSubscription<Position> positionStream;
  ValueNotifier<Position> val;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    val = new ValueNotifier(null);
    val.addListener(() {
//      print('qwert');
//      print(val.value.longitude + val.value.latitude);
    });

    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
        timeInterval: 0);
//    print('hello');
    var geolocator = Geolocator();

    positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
//      print("new location");
//      print(position == null
//          ? 'Unknown'
//          : position.latitude.toString() +
//              ', ' +
//              position.longitude.toString());
      if (position != null) {
        val.value = position;
//        print('hello ${widget.uid}');
        enterLocationdata(preferences: widget.preferences,position: position);
        Firestore.instance
            .collection(CnString.fusercollectiom)
            .document(widget.uid)
            .updateData({
          'lat': position.latitude,
          "long": position.longitude,
        });
//               Geolocator().placemarkFromCoordinates(position.latitude, position.longitude).then((place){
//                 print("locations");
//
//               });
//
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg"),
                      fit: BoxFit.cover)),
              accountEmail: new Text(widget.email),
              accountName: new Text(widget.name),
              currentAccountPicture: ClipOval(
                  child: CachedNetworkImage(
                imageUrl: widget.photo,
              )),
            ),
            InkWell(
                onTap: () => logout(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                      leading: Icon((Icons.exit_to_app)),
                      title: new Text("Log Out")),
                )),
            new Divider(
              color: Colors.black,
            ),
            InkWell(
                onTap: () => cnAddpeople(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                      leading: Icon((Icons.person_add)),
                      title: new Text("Add Friends")),
                )),
            new Divider(
              color: Colors.black,
            ),
            InkWell(
                onTap: () => acceptRequests(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                      leading: Icon((Icons.notification_important)),
                      title: new Text("Requests")),
                )),
            new Divider(
              color: Colors.black,
            ),
            InkWell(
                onTap: () async {
                  PermissionStatus permission = await PermissionHandler()
                      .checkPermissionStatus(PermissionGroup.contacts);
//                  print("permission");
//                  print(permission);
                  if (PermissionStatus.granted == permission) {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) => TextSEnder()));
                  } else {
                    Map<PermissionGroup, PermissionStatus> permissions =
                        await PermissionHandler()
                            .requestPermissions([PermissionGroup.contacts]);

                    if (permissions[PermissionGroup.contacts] ==
                        PermissionStatus.granted) {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) => TextSEnder()));
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: new Icon((Icons.message)),
                    title: new Text("Invite Friends"),
                  ),
                )),
            new Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text(CnString.home),
        actions: <Widget>[],
      ),
      body: new Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(CnString.fusercollectiom)
              .document(widget.uid)
              .collection(CnString.ffrens)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//            print("sd");
//            print(positionStream);
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return new CNHomeScreenCard(
                      frenUid: document[CnString.uid],
                      val: val,
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  logout() async {
    await cnLogout();
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin()));
  }

  acceptRequests(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    Navigator.of(context).push(CupertinoPageRoute(
        builder: (BuildContext context) => CNAcceptRequests(
              uid: sp.getString(CnString.uid),
            )));
  }
}
