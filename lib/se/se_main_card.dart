import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:on_day/se/resturant_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:on_day/SString.dart';
class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(

      ),
      appBar: new AppBar(title: new Row(children: <Widget>[
        new Text("Deliver to: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
        new Text("Home",style: TextStyle(color: Colors.pink,fontWeight:FontWeight.bold),)
      ],),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.pink),),
      body:ListView(
        
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(child :new Row(children: <Widget>[
              new Icon(Icons.search,color: Colors.pink,),Expanded(child: new TextField(decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Resturants',
              ),))
            ],)),
          ),
      StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new Column(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new SECard();
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
class SECard extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  SECard({this.documentSnapshot});
  @override
  _SECardState createState() => _SECardState();
}

class _SECardState extends State<SECard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.pink,
      onTap: (){
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context) =>ResturantView(documentSnapshot: widget.documentSnapshot,)));
      },
      child: new Card(

        elevation: 4.0,
        child: Wrap(
          children: <Widget>[
            Stack(
              children: <Widget>[

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.documentSnapshot.data[ModelResturants.image],
                      height: 220.0,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => new Shimmer.fromColors(child: SizedBox(height: 220,), highlightColor: Colors.blue,baseColor: Colors.pink,direction: ShimmerDirection.ltr,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                    child: Align(child: new AutoSizeText(widget.documentSnapshot.data[ModelResturants.name],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),maxLines: 1,),alignment: Alignment.centerLeft),
                  ),
//              new Icon(Icons)
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          (widget.documentSnapshot.data[ModelResturants.minOrder]>=300||widget.documentSnapshot.data[ModelResturants.minOrder]<=300)?new Text("\$",style: TextStyle(color: Colors.blue,fontSize: 15),):new Text("\$",style: TextStyle(color: Colors.grey,fontSize: 18),),
                          (widget.documentSnapshot.data[ModelResturants.minOrder]>=500)?new Text("\$",style: TextStyle(color: Colors.blue,fontSize: 15),):new Text("\$",style: TextStyle(color: Colors.grey,fontSize: 18),),
                          (widget.documentSnapshot.data[ModelResturants.minOrder]>=1000)?new Text("\$",style: TextStyle(color: Colors.blue,fontSize: 15),):new Text("\$",style: TextStyle(color: Colors.grey,fontSize: 18),),
                          new Text(widget.documentSnapshot.data[ModelResturants.shortDescription],style: TextStyle(color: Colors.grey,fontSize: 18),),


                        ],),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0,bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          new Text("Rs ${widget.documentSnapshot.data[ModelResturants.minOrder]}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          new Text(" minimum",style: TextStyle(color: Colors.grey,fontSize: 15,),),
                          new Text(" | Free",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          new Text(" ${widget.documentSnapshot.data[ModelResturants.free]}  ",style: TextStyle(color: Colors.grey,fontSize: 15,),),




                        ],
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,

                  child: new Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("   ${widget.documentSnapshot.data[ModelResturants.deliveryTime]} \n Mins",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:18.0,left: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,

                    child: new Container(
                      color: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("   Free ${widget.documentSnapshot.data[ModelResturants.free]}   ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
