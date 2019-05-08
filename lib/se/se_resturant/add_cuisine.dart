import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_day/SString.dart';
import 'dart:convert';
class CuisineAdder extends StatefulWidget {
  SharedPreferences sharedPreferences;
  DocumentSnapshot documentSnapshot;
  var map;
  CuisineAdder({this.documentSnapshot,this.sharedPreferences,this.map});
  @override
  _CuisineAdderState createState() => _CuisineAdderState();
}

class _CuisineAdderState extends State<CuisineAdder> {
  final formkey1=GlobalKey<FormState>();
  var a;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("New Cuisine"),backgroundColor: Colors.pink,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Form(
              key: formkey1,
              child: new Card(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Enter New Cuisine",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 24),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new TextFormField(
                      validator: (val)=>val1(val),
                      onSaved: (val){
                        name=val;

                        a.add(name);
                      },
                      decoration: InputDecoration(labelText: "Unique Cuisine",border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new RaisedButton(onPressed: ()=>pressed(),child: new Text('Submit',style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),color: Colors.pink,),
                  )
                ],),
              ),
            ),
          )
        ],
      ),
    );
  }

  pressed(){
    if(formkey1.currentState.validate())
      {

        formkey1.currentState.save();
        Firestore.instance.document('resturants/${widget.sharedPreferences.getString(CnString.restID)}').updateData({
          ModelResturants.cuisinesList:a
        }).then((val){
          Firestore.instance.document('resturants/${widget.sharedPreferences.getString(CnString.restID)}/cuisines/${name}').setData({
            'name':name
          }).then((val2){
            Firestore.instance.document("resturants/${widget.sharedPreferences.getString(CnString.restID)}").get().then((val4){
              widget.sharedPreferences.setString('doc', json.encode(val4.data));
              Navigator.pop(context);

            });

          });
        });
      }

  }
  val1(String val){
    if(widget.documentSnapshot!=null){
      a= widget.documentSnapshot.data[ModelResturants.cuisinesList];
     print(a);
      if(a.contains(val))
        {
          return "use a unique value";
        }
        else
        return null;
    }
    else{
       a= widget.map[ModelResturants.cuisinesList];
      print(a);
      if(a.contains(val))
      {
        return "use a unique value";
      }
      else
      return null;
    }

  }
}
