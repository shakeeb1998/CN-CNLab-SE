import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
import 'package:on_day/common/login.dart';
import 'package:on_day/se/Orders.dart';
import 'package:on_day/se/se_main_card.dart';
import 'package:on_day/SString.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
class SEHomeScreen extends StatefulWidget {
  SharedPreferences sharedPreferences;
  SEHomeScreen({this.sharedPreferences});
  @override
  _SEHomeScreenState createState() => _SEHomeScreenState();
}

class _SEHomeScreenState extends State<SEHomeScreen> {
  TextEditingController textEditingController=new TextEditingController();
  var a;
  bool kill=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a=Firestore.instance.collection(ModelResturants.modelName).snapshots();
    textEditingController.addListener((){
      print('Listenr');
      if(textEditingController.text.length>0){
        setState(() {
          kill=true;
        });
      }
      else if (textEditingController.text.length==0)
        {
          kill=false;
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider("https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg"),fit: BoxFit.cover)),
                accountEmail: new Text(widget.sharedPreferences.getString(CnString.email)),
                accountName: new Text(widget.sharedPreferences.getString(CnString.name)),
                currentAccountPicture: ClipOval(

                    child: CachedNetworkImage(imageUrl: widget.sharedPreferences.getString(CnString.photourl),)),
              ),
              new ListTile(leading: new Icon(Icons.bookmark_border),title: new Text("Current Orders"),onTap: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (BuildContext context) => Orders(sharedPreferences: widget.sharedPreferences,)));
              },),
              new ListTile(leading: new Icon(Icons.exit_to_app),title: new Text("Log Out"),onTap: () async {
                await cnLogout();
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app:"2" ,)));
              },)
            ],
          ),

        ),
        appBar: new AppBar(title: new Row(children: <Widget>[
          new Text("Deliver to: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
          Row(
            children: <Widget>[
              new AutoSizeText("Home",style: TextStyle(color: Colors.pink,fontWeight:FontWeight.bold),maxLines: 1,),
            ],
          )
        ],),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.pink),),
        body:ListView(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(child :new Row(children: <Widget>[
                new Icon(Icons.search,color: Colors.pink,),Expanded(child: new TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Resturants',
                ),))
              ],)),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: a,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return new Text('Loading...');
                  default:
                    return new Column(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return (!kill)?new SECard(documentSnapshot: document,):(document.data[ModelResturants.name].toString().toLowerCase().contains(textEditingController.text))?SECard(documentSnapshot: document,):new Container();
                      }).toList(),
                    );
                }
              },
            )
          ],
        )
    );
  }
}
