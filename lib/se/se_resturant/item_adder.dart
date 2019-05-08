import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:on_day/SString.dart';
class ItemAdder extends StatefulWidget {
   DocumentSnapshot documentsnap; var map; int currentIndex; BuildContext context;
   SharedPreferences sharedPreferences;
   ItemAdder({@required this.documentsnap,@required this.map,@required this.currentIndex,@required this.context,this.sharedPreferences});
  @override
  _ItemAdderState createState() => _ItemAdderState();
}

class _ItemAdderState extends State<ItemAdder> {
  File imageFile;
  String url,name,shortDescriton;
  int price;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: new AppBar(title: new Text('Add Items'),backgroundColor: Colors.pink,),
    
    body: new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      (imageFile==null)?InkWell(child: new Icon(Icons.image,size:150,color: Colors.pink ,),onTap: ()=>addImage(),):ClipRRect(child: Image.file(imageFile,height: 150,width: 150,),borderRadius: BorderRadius.circular(8.0),),
                      //
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (val)=>nameVal(val),
                          onSaved: (val)=>savName(val),
                          decoration: InputDecoration(labelText: 'Name ',border: OutlineInputBorder(borderRadius: BorderRadius.circular( 8.0)),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (val)=>priceVal(val),
                          onSaved: (val)=>savPrice(val),
                          decoration: InputDecoration(labelText: 'Price ',border: OutlineInputBorder(borderRadius: BorderRadius.circular( 8.0)),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (val)=>descVal(val),
                          onSaved: (val)=>saveDesc(val),
                          decoration: InputDecoration(labelText: 'Short Description ',border: OutlineInputBorder(borderRadius: BorderRadius.circular( 8.0)),),),
                      ),



                      //
                      new RaisedButton(onPressed: ()=>addItem(),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),color: Colors.pink,child: new Text('Add item',style: TextStyle(color: Colors.white),),)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    
    )
      
      
      
    
    
    ;
    
  }
  addImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      
    });
  }
  addItem(){

    if(imageFile!=null)
      {
        if(formKey.currentState.validate())
          {
            formKey.currentState.save();
            _showDialog(context,name: name,imageFile: imageFile,prefs: widget.sharedPreferences,desc: shortDescriton,map: widget.map,currIndex: widget.currentIndex,ds: widget.documentsnap,price: price);

          }
      }
  }
  String nameVal(String name){
    if (name.length<3)
      {
        return "Too short";
      }
      else
        return null;

  }
  String descVal(String name){
    if (name.length<10)
    {
      return "Too short";
    }
    else
      return null;

  }
  String priceVal(String name){
   if(name.length>0)
     {
       int a=int.parse(name);
       if (a<50)
       {
         return "Too cheap";
       }
       else
         return null;
     }
     else{
       return "Type Something";
   }
   
  }
  savName(String val)
  {
    name=val;
  }
  savPrice(String val)
  {
    price=int.parse(val);
  }
  saveDesc(String val)
  {
    shortDescriton=val;
  }
}

void _showDialog(BuildContext context,{BuildContext scaffold,File imageFile,String name,int currIndex,DocumentSnapshot ds,var map,SharedPreferences prefs,int price,String desc}) {

  Navigator.pop(context);
//  Scaffold.of(scaffold).showSnackBar(SnackBar(
//    content: Text('You have no resturant contact admin contact admin'),
//    duration: Duration(seconds: 3),
//  ));
  // flutter defined function
  bool placing = true;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        StorageReference ref =
        FirebaseStorage.instance.ref().child(name).child("image.jpg");
        StorageUploadTask uploadTask = ref.putFile(imageFile);
          (uploadTask.onComplete).then((val){
            print('url');
            print(val.ref.getDownloadURL().then((q){
              print(q.toString());

              if(ds!=null)
                {
                  var a=ds.data[ModelResturants.cuisinesList];
                  String b=a[currIndex];
                  String refrence=ModelResturants.modelName+"/"+prefs.getString(CnString.restID)+"/"+ModelResturants.cusines+"/"+b+'/'+"variants";

                  Firestore.instance.collection(refrence).add({
                    ModelFoodItem.name:name,
                    ModelFoodItem.price:price,
                    ModelFoodItem.image:q.toString(),
                    ModelFoodItem.shortDescription:desc,

                  });
                }
                else{
                var a=map[ModelResturants.cuisinesList];
                String b=a[currIndex];
                String refrence=ModelResturants.modelName+"/"+prefs.getString(CnString.restID)+"/"+ModelResturants.cusines+"/"+b+'/'+"variants";

                Firestore.instance.collection(refrence).add({
                  ModelFoodItem.name:name,
                  ModelFoodItem.price:price,
                  ModelFoodItem.image:q.toString(),
                  ModelFoodItem.shortDescription:desc,

                });

              }



            }));
            val.toString();
            Navigator.pop(context);
          });

        ;



        return AlertDialog(
          title: new Text("Uploading Item"),
          content: (placing)?Row(
            children: <Widget>[
              Wrap  (
                children: <Widget>[
                  new CircularProgressIndicator(),
                ],
              ),
            ],
          ):new Text('Order Placed'),
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
      }
  );
}
