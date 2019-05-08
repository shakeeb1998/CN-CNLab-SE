import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/se/se_main_card.dart';

import 'checkout.dart';
import 'food_item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:on_day/SString.dart';
class ResturantView extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  ResturantView({this.documentSnapshot});
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState(documentSnapshot: documentSnapshot);
}

class _SilverAppBarWithTabBarState extends State<ResturantView>
    with SingleTickerProviderStateMixin {
  ValueNotifier <Map<String,dynamic>> cart;
  DocumentSnapshot documentSnapshot;

  List<Widget>tabsList;
  List<Widget>tabBarview;
  TabController controller;
  _SilverAppBarWithTabBarState({this.documentSnapshot})
  {
    tabBarview=new List();
    tabsList= new List();
    for(String i in documentSnapshot.data[ModelResturants.cuisinesList])
      {
        tabsList.add(new Tab(text: i,));
        tabBarview.add(StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(ModelResturants.modelName+"/${documentSnapshot.documentID}/cuisines/${i}/variants").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                return new ListView(
                  children: [
                    Column(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return new FoodItemCard(documentSnapshot: document,cart: cart,);
                      }).toList(),
                    ),
                  ],
                );
            }
          },
        ));


      }
  }

  @override
  void initState() {
    super.initState();
    cart= new ValueNotifier({"s":1});
    controller = TabController(
      length: documentSnapshot.data[ModelResturants.cuisinesList].length,
      vsync: this,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.pink,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Lasania",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: CachedNetworkImage(imageUrl:"https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg" ,fit: BoxFit.cover,)),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: controller,
                  indicatorColor: Colors.pink,
                  isScrollable: true,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(color: Colors.black),
                  tabs:tabsList ,
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body:Stack(
          children: <Widget>[
            TabBarView(children: tabBarview,controller: controller,),
            Align(alignment: Alignment.bottomCenter,child: Row(
              children: <Widget>[
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(borderRadius: BorderRadius.circular(8.0),child: new RaisedButton(onPressed: (){
//                      CheckOut
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) =>CheckOut(cart: cart,documentSnapshot: documentSnapshot,)));

                  },child: new Text("View Cart",style: TextStyle(color: Colors.white),),color: Colors.pink,)),
                )),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}