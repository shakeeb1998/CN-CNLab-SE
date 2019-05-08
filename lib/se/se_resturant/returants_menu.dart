import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_day/cn/functions/loginFunctions.dart';
import 'package:on_day/common/login.dart';
import 'package:on_day/se/se_main_card.dart';
import 'package:on_day/se/se_resturant/resturants_orders.dart';
import 'add_cuisine.dart';
import 'resturant_functions.dart';
import '../checkout.dart';
import '../food_item_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:on_day/SString.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ResturantHomeScreen extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  SharedPreferences preferences;
  Map <String,dynamic>map;

  ResturantHomeScreen({this.documentSnapshot,this.map,this.preferences});
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState(documentSnapshot: documentSnapshot,map:map,preferences:preferences);
}

class _SilverAppBarWithTabBarState extends State<ResturantHomeScreen>
    with SingleTickerProviderStateMixin {
  SharedPreferences preferences;

  Map <String,dynamic>map;

  ValueNotifier <Map<String,dynamic>> cart;
  DocumentSnapshot documentSnapshot;

  List<Widget>tabsList;
  List<Widget>tabBarview;
  TabController controller;
  _SilverAppBarWithTabBarState({this.documentSnapshot,this.map,this.preferences})
  {
    tabBarview=new List();
    tabsList= new List();
   if(documentSnapshot!=null){
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
                   new RaisedButton(onPressed:()=> addItemToCuisine(map: map,currentIndex: controller.index,documentsnap: documentSnapshot,context: context,prefs: preferences),child: new Text("Add To Cuisine",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),color: Colors.pink,),
                 ],
               );
           }
         },
       ));


     }
   }
   else{
     for(String i in map[ModelResturants.cuisinesList])
     {
       tabsList.add(new Tab(text: i,));
       tabBarview.add(StreamBuilder<QuerySnapshot>(
         stream: Firestore.instance.collection(ModelResturants.modelName+"/${preferences.getString(CnString.restID)}/cuisines/${i}/variants").snapshots(),
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
                   new RaisedButton(onPressed:()=> addItemToCuisine(map: map,currentIndex: controller.index,documentsnap: documentSnapshot,context: context,prefs: preferences),child: new Text("Add To Cuisine",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),color: Colors.pink,),
                 ],
               );
           }
         },
       ));


     }
   }
  }

  @override
  void initState() {
    super.initState();
    cart= new ValueNotifier({"s":1});
    controller = TabController(
      length: (documentSnapshot!=null)?documentSnapshot.data[ModelResturants.cuisinesList].length:map[ModelResturants.cuisinesList].length,
      vsync: this,

    );
  }

  @override
  Widget build(BuildContext context) {
    print('stupid shet');
    return Scaffold(
      drawer: new Drawer(child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(image: (documentSnapshot!=null)?DecorationImage(image: CachedNetworkImageProvider( documentSnapshot.data[ModelResturants.image],),fit: BoxFit.cover):DecorationImage(image: CachedNetworkImageProvider( map[ModelResturants.image]),fit: BoxFit.cover)),
              accountName: (documentSnapshot==null)?new Text(preferences.getString(CnString.name)):new Text(documentSnapshot.data[CnString.name].toString()),
              accountEmail:(documentSnapshot==null)? new Text(preferences.getString(CnString.email)):new Text(documentSnapshot.data['ownerEmail'].toString()),
            currentAccountPicture: (documentSnapshot==null)?CircleAvatar(backgroundImage: CachedNetworkImageProvider( preferences.getString(CnString.photourl)),):CircleAvatar(backgroundImage: CachedNetworkImageProvider( documentSnapshot.data['image']),),
          ),

        new ListTile(leading: new Icon(Icons.fastfood),title: new Text("Add cuisines"),onTap: (){
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (BuildContext context) => CuisineAdder(sharedPreferences: preferences,documentSnapshot: documentSnapshot,map: map,)));
        },),
          InkWell(onTap:(){
            print("death");
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (BuildContext context) => RestOrders(sharedPreferences: preferences,)));
          },child: new ListTile(leading: new Icon(Icons.attach_money),title: new Text("orders"),)),
          new ListTile(leading: new Icon(Icons.exit_to_app),title: new Text("Logout"),onTap: (){


            cnLogout();
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (BuildContext context) => FireBaseLogin(app: '3',)));
          },),
        ],
      ),),

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
//                Expanded(child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: ClipRRect(borderRadius: BorderRadius.circular(8.0),child: new RaisedButton(onPressed: (){
////                      CheckOut
//                    Navigator.of(context).push(
//                        CupertinoPageRoute(builder: (BuildContext context) =>CheckOut(cart: cart,documentSnapshot: documentSnapshot,)));
//
//                  },child: new Text("View Cart",style: TextStyle(color: Colors.white),),color: Colors.pink,)),
//                )
//                ),
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