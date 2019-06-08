import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:on_day/eWallet/HomePage/bottom_tab.dart';
import 'package:on_day/eWallet/qr_screen.dart';
import 'package:on_day/eWallet/sign_in.dart';
import 'package:on_day/eWallet/sign_up.dart';
import 'package:on_day/eWallet/transfer.dart';
import 'package:on_day/eWallet/withdraw.dart';
import 'package:qr_reader/qr_reader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import 'history.dart';
class WalletHome extends StatefulWidget {
  @override
  _WalletHomeState createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  TabBarView list=new TabBarView(children: [
    Home(),Merchants()
  ]);
  IndexController indexController=new IndexController();
  TransformerPageController transformerPageController=new TransformerPageController(initialPage: 0,itemCount: 2);


  int currentIndex = 0;
  Widget bodyWidget = Home();
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexController.addListener((){
      print('www');
    });
    transformerPageController.addListener((){
     // print(indexController);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(child: 
        new ListView(children: <Widget>[





          new ListTile(title: new Text("Logout"),onTap: (){
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (BuildContext context) =>SignIn(),));
          },
          ),
        ],
        )
        ,
      ),
      backgroundColor: Color.fromRGBO(237, 237, 237, 1),
      body: Stack(
        children: <Widget>[
          Align(
            child: TransformerPageView(
              onPageChanged: (val){
                print('help me ${val}');
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;

                fState.setPage(val);
                fState.setState((){
                  currentIndex=val;
                });
                // fState.setPage(val);
//              setState(() {
//                currentIndex=val;
//              });

              },
                controller: indexController,
                pageController: transformerPageController,


                loop: true,
                itemBuilder: (BuildContext context, int index) {
                  return list.children[index];
                },
                itemCount: 2
            ),
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: new FancyBottomNavigation(

              textColor: Color.fromRGBO(72, 21, 88, 1),
              activeIconColor: Colors.white,
              circleColor: Color.fromRGBO(72, 21, 88, 1),
              inactiveIconColor: Color.fromRGBO(72, 21, 88, 1),
              key: bottomNavigationKey,
              tabs: [
                TabData(iconData: Icons.home, title: "Home"),
                TabData(iconData: Icons.list, title: "Merchants")
              ],
              onTabChangedListener: (position) {
                setState(() {
                  currentIndex = position;
                  if (position == 0) {
                    //currentIndex=0;
                   transformerPageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);

                    bodyWidget = Home();
                  } else  {
                    bodyWidget = Merchants();
                   // currentIndex=1;
                   transformerPageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: new Align(
                alignment: Alignment.bottomCenter,

                child: new FloatingActionButton(
                  backgroundColor: Color.fromRGBO(72, 21, 88, 1),
                  onPressed: (){
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) =>QRScreen(),));


                  },
                  child: new Text("QR"),
                )),
          )
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //image name and number

        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, top: 30),
          child: new CircleAvatar(
            maxRadius: 30,
            backgroundImage: CachedNetworkImageProvider(
                "https://www.kiplinger.com/kipimages/pages/19045.jpg"),
          ),
        ),

        new Column(
          children: <Widget>[
            new Text(
              "Safeer Ahmed",
              style: TextStyle(color: Colors.grey, fontSize: 24),
            ),
            new Text(
              "0341 0000000",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),

        //image name and number

        //Name and balance
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(72, 21, 88, 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        new Text(
                          "Balance",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        new AutoSizeText(

                          "Rs 20000",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Name and balance

        //options
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Colors.white),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                SizedBox(height: 25,),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                  CupertinoPageRoute(builder: (BuildContext context) =>Transfer(),));
                            },
                            child: new Icon(Icons.send,color: Color.fromRGBO(72, 21, 88, 1),size: 80,)),
                        new Text('Transfer',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(72, 21, 88, 1),fontSize: 16),)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(onTap: (){
                          Navigator.of(context).push(
                              CupertinoPageRoute(builder: (BuildContext context) =>Withdraw(),));

                        },child: new Icon(Icons.file_download,color: Color.fromRGBO(72, 21, 88, 1),size: 80,)),
                        new Text('Withdraw',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(72, 21, 88, 1),fontSize: 16),)

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 25,),


                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Column(
                    children: <Widget>[
                      InkWell(onTap: (){
              Navigator.of(context).push(
              CupertinoPageRoute(builder: (BuildContext context) =>History(),));

              },child: new Icon(Icons.history,color: Color.fromRGBO(72, 21, 88, 1),size: 80,)),
                      InkWell(child: new Text('History',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(72, 21, 88, 1),fontSize: 16),))

                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new Icon(Icons.announcement,color: Color.fromRGBO(72, 21, 88, 1),size: 80,),
                      new Text('Promotions',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(72, 21, 88, 1),fontSize: 16),)

                    ],
                  ),



                ],),
              ],
          ),
        ),
            ))

          ,

        //options


      ],
    );
  }
}

class Merchants extends StatefulWidget {
  @override
  _MerchantsState createState() => _MerchantsState();
}

class _MerchantsState extends State<Merchants> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Text("No Merchants Yet"),
    );
  }
}
