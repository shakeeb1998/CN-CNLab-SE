import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_day/SString.dart';
class Orders extends StatefulWidget {
  SharedPreferences sharedPreferences;
  String resturantOrderref;
  Orders({this.sharedPreferences,this.resturantOrderref});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: new AppBar(backgroundColor: Colors.pink,title: new Text("Orders"),bottom: new TabBar(
            indicatorColor: Colors.pink,
            tabs: [
          new Tab(text: "Current Orders",),
          new Tab(text:'History')
        ]),),
        body: new TabBarView(children: [
          StreamBuilder<QuerySnapshot>(
            stream: (widget.resturantOrderref==null)?Firestore.instance.collection('user/${widget.sharedPreferences.getString(CnString.uid)}/currentOrders').snapshots():Firestore.instance.collection(widget.resturantOrderref+'/currentOrders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new OrderCard(documentSnapshot: document,resturantOrderref: widget.resturantOrderref,);
                    }).toList(),
                  );
              }
            },
          ),
          new StreamBuilder<QuerySnapshot>(
            stream: (widget.resturantOrderref==null)?Firestore.instance.collection('user/${widget.sharedPreferences.getString(CnString.uid)}/history').snapshots():Firestore.instance.collection(widget.resturantOrderref+"/history").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new OrderCard(documentSnapshot: document,resturantOrderref: widget.resturantOrderref,docref: 'q',);
                    }).toList(),
                  );
              }
            },
          ),
        ])
      ),
    );
  }
}


class OrderCard extends StatefulWidget {
  String resturantOrderref;

  DocumentSnapshot documentSnapshot;
  String docref;
  OrderCard({this.documentSnapshot,this.resturantOrderref,this.docref}){
    print('qwertfgy');
  }
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (widget.resturantOrderref==null)?Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[new Text("Resturant:  ",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),new Text(widget.documentSnapshot.data[ModelOrderC.restName])],),
            ):new Container(),
            new Text("Order Status",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w300,fontSize: 20),),
            (widget.resturantOrderref==null)?((widget.docref==null)?new OrderStepper(docref:'resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.data[ModelOrderC.orderID]}'):new Text("Is Paid For")):new Container(),
            new ExpansionTile(

              title: new Text("Order Details",style: TextStyle(color:Colors.pink ),),
              children: <Widget>[
                OrderList(map: widget.documentSnapshot.data[ModelOrderC.details],documentSnapshot: widget.documentSnapshot,)
            ],),
            (widget.resturantOrderref!=null)?OrderController(documentSnapshot: widget.documentSnapshot,):new Container(),
            (widget.resturantOrderref!=null)?new Text("Delivering To",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold)):new Container(),

            (widget.resturantOrderref!=null)?new Text(widget.documentSnapshot.data['name']):new Container()
          ],
        ),
      ),
    );
  }
}
class OrderList extends StatefulWidget {
  var map;
  DocumentSnapshot documentSnapshot;
  OrderList({this.map,this.documentSnapshot});
  @override
  _OrderListState createState() => _OrderListState(map: map,documentSnapshot: documentSnapshot);
}

class _OrderListState extends State<OrderList> {
  List <Widget> list;
  DocumentSnapshot documentSnapshot;

  var map;
  _OrderListState({this.map,this.documentSnapshot}){
    print('hello');
    print(documentSnapshot.data);
    list=new List();
    for (String i in map.keys)
      {
        if(i==ModelOrderC.s || i==ModelOrderC.subTotal)
          {
            continue;
          }
          else
            {
            list.add(new ListTile(leading: new Text(map[i]['name']),title: new Text("(x ${map[i]['quantity']})",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),trailing: new Text("Rs ${map[i]['totalPrice'].toString()}",style: TextStyle(color: Colors.pink),),));
        }

      }
      list.add(new ListTile(trailing: new Text("SubTotal Rs ${map['subTotal']}",style: TextStyle(fontWeight: FontWeight.bold),),));
  }
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }
}
class OrderStepper extends StatefulWidget {
  String docref;
  OrderStepper({this.docref});
  @override
  _OrderStepperState createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.document(widget.docref).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)  {

        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            print("222222222222222222222222222222");
            print(widget.docref);
            print(snapshot.data);
//
//            print(snapshot.data.data);

            return new Text("loading");

        }
        else
          {

            print("helpkjkjnj");
            print(widget.docref);
            print(snapshot.data['ack']);
            print(snapshot.data['deliveryBoy']);
            print(snapshot.data['kitchen']);
            print(snapshot.data['paid']);


            print(snapshot.data['ack']==true && snapshot.data['deliveryBoy']==false && snapshot.data['kitchen']==false &&!snapshot.data['paid']==false );
            print(snapshot.data.data);

            return new SizedBox(

              height: 120,
              child: Theme(data: ThemeData(
                  accentColor: Colors.pink,
                  primaryColor: Colors.pink
              ), child:Stepper(
                type: StepperType.horizontal,

                controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      Container(
                        child: null,
                      ),
                      Container(
                        child: null,
                      ),
                    ],
                  );
                },

                currentStep: (snapshot.data['ack'] && !snapshot.data['deliveryBoy'] &&!snapshot.data['kitchen'] &&!snapshot.data['paid'] )?0:(snapshot.data['ack'] && !snapshot.data['deliveryBoy'] &&snapshot.data['kitchen'] &&!snapshot.data['paid'] )?1:
                (snapshot.data['ack'] && snapshot.data['deliveryBoy'] &&snapshot.data['kitchen'] &&!snapshot.data['paid'] )?2:3
                ,steps: [
                Step(title: new Text(""),content:new Center(child:new Text("Is Acknoledged")),isActive: (snapshot.data['ack'] && !snapshot.data['deliveryBoy'] &&!snapshot.data['kitchen'] &&!snapshot.data['paid'] )?true:false,),
                Step(title: new Text(""),content:new Center(child:new Text("Is In Kitchen")),isActive: (snapshot.data['ack'] && !snapshot.data['deliveryBoy'] &&snapshot.data['kitchen'] &&!snapshot.data['paid'] )?true:false,),
                Step(title: new Text(""),content:new Center(child:new Text("Is Given To Delivery Boy")),isActive: (snapshot.data['ack'] && snapshot.data['deliveryBoy'] &&snapshot.data['kitchen'] &&!snapshot.data['paid'] )?true:false,),
                Step(title: new Text(""),content:new Center(child:new Text("Is Paid ")),isActive: (snapshot.data['ack'] && snapshot.data['deliveryBoy'] &&snapshot.data['kitchen'] &&snapshot.data['paid'] )?true:false,),


              ],)),
            );
          }


      },
    );
  }
  int stepFinder(DocumentSnapshot snapshot){
    if(snapshot.data['ack'] && !snapshot.data['deliveryBoy'] &&!snapshot.data['kitchen'] &&!snapshot.data['paid'] )
    return 3;

  }
}
class OrderController extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  OrderController({this.documentSnapshot});
  @override
  _OrderControllerState createState() => _OrderControllerState();
}

class _OrderControllerState extends State<OrderController> {
  @override
  Widget build(BuildContext context) {
    print("trouble");
    print(widget.documentSnapshot.data);
    return new Column(
      children: <Widget>[
        new Row(children: <Widget>[
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(onPressed: (widget.documentSnapshot.data['ack']==false)?()=>ack():null,color: Colors.red,child: new Text("Acknoledged",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),),
          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(onPressed: (widget.documentSnapshot.data['kitchen']==false)?()=>kitchen():null,color: Colors.amber,child: new Text("Kitchen",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          )),
        ],),
        new Row(children: <Widget>[
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(onPressed: (widget.documentSnapshot.data['deliveryBoy']==false)?()=>delivery():null,color: Colors.yellow,child: new Text("In Route",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(onPressed:(widget.documentSnapshot.data['paid']==false)? ()=>paid():null,color: Colors.lightGreenAccent,child: new Text("Paid",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          )),
        ],),
      ],
    );
  }
  ack(){
    Firestore.instance.document("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.documentID}").updateData({"ack":true});


  }
  kitchen(){
    if(widget.documentSnapshot['ack'])
      {
        Firestore.instance.document("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.documentID}").updateData({"kitchen":true});

      }

  }
  delivery() {
    if (widget.documentSnapshot['ack'] && widget.documentSnapshot['kitchen']) {
      Firestore.instance.document(
          "resturants/${widget.documentSnapshot.data[ModelOrderC
              .restID]}/currentOrders/${widget.documentSnapshot.documentID}")
          .updateData({"deliveryBoy": true});
    }
  }
  paid(){
    if(widget.documentSnapshot['ack']&& widget.documentSnapshot['kitchen']&&widget.documentSnapshot['deliveryBoy'])
    {
      Firestore.instance.document("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.documentID}").updateData({"paid":true});
      Firestore.instance.document("user/${widget.documentSnapshot.data['uid']}/currentOrders/${widget.documentSnapshot.documentID}").get().then((v) {
        Firestore.instance.document(
            "user/${widget.documentSnapshot.data['uid']}/currentOrders/${widget
                .documentSnapshot.documentID}").delete();
        Firestore.instance.collection(
            "user/${widget.documentSnapshot.data['uid']}/history").add(v.data);
      });
      Firestore.instance.document("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.documentID}").get().then((ds){
        Firestore.instance.document("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/currentOrders/${widget.documentSnapshot.documentID}").delete();
        Firestore.instance.collection("resturants/${widget.documentSnapshot.data[ModelOrderC.restID]}/history").add(ds.data);
      });
    }


  }
}


