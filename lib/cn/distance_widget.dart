import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:ringtone/ringtone.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DistanceFinder extends StatefulWidget {
  double startLatitude,startLongitude,endLatitude,endLongitude;
  ValueNotifier <Position>valueNotifier;
  String uid;
  DistanceFinder({this.endLatitude,this.endLongitude,this.startLatitude,this.startLongitude,this.valueNotifier,this.uid});
  @override
  _DistanceFinderState createState() => _DistanceFinderState();
}

class _DistanceFinderState extends State<DistanceFinder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.valueNotifier.addListener((){
      setState(() {
        widget.startLongitude=widget.valueNotifier.value.longitude;
        widget.startLatitude=widget.valueNotifier.value.latitude;

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator().distanceBetween(widget.startLatitude, widget.startLongitude, widget.endLatitude, widget.endLongitude),
      builder: (BuildContext context,AsyncSnapshot<double>snapshot){
        if(snapshot.connectionState==ConnectionState.done)
          {
//            Ringtone.play();
//            Vibration.vibrate(duration: 10000);
//        Vibration.

        SharedPreferences.getInstance().then((shared){
          bool uid=shared.getBool("alert"+widget.uid);
          if(uid){
           if((snapshot.data)>10)
             {
               Vibration.cancel();
               Vibration.vibrate();
             }
          }
          else{

          }
        });



            print("disatnce calcukations");
            return new AutoSizeText((snapshot.data.toString()).toString(),maxLines: 1,);
          }
          else
            {
              return new Text("Calculating");
            }

      },
    );
  }
}
class AlertToggle extends StatefulWidget {
  String uid;
  AlertToggle({@required this.uid});
  @override
  _AlertToggleState createState() => _AlertToggleState();
}

class _AlertToggleState extends State<AlertToggle> {
  bool val;
  Future <SharedPreferences>fut;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fut=SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fut,
      builder: (BuildContext context,AsyncSnapshot<SharedPreferences>snapshot){
        if(snapshot.connectionState==ConnectionState.done)

          {
            if(snapshot.data.getBool("alert"+widget.uid)!=null)
              {
                val=snapshot.data.getBool("alert"+widget.uid);

                return new Switch(value: val, onChanged: (bool va){
                  setState(() {
                    val=va;
                    snapshot.data.setBool("alert"+widget.uid,va);

                  });
                });

              }
              else
                {
                  val=false;

                  return new Switch(value: val, onChanged: (bool va){
                    setState(() {
                      val=va;
                      snapshot.data.setBool("alert"+widget.uid,va);
                    });
                  });                }
          }
          else
            {
              return new Text("loading");
            }
      },
    );
  }
}
class Place extends StatefulWidget {
  Position p;
  Place({this.p});
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator().placemarkFromCoordinates(widget.p.latitude, widget.p.longitude),
      builder: (BuildContext context,AsyncSnapshot<List<Placemark>>snapshot){
        if (snapshot.connectionState==ConnectionState.done)
          {
            return new Text(snapshot.data.first.name);
          }
          else{
            return new Text("loading");
        }
      },
    );
  }
}

