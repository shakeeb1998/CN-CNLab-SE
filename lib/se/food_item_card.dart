import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_day/SString.dart';
class FoodItemCard extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  ValueNotifier <Map<String,dynamic>>cart;
  FoodItemCard({this.documentSnapshot,this.cart});
  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       if (widget.cart.value.containsKey(widget.documentSnapshot.documentID))
         {
           print("if");
           Map <String,dynamic>map=widget.cart.value;
           dynamic a=map[widget.documentSnapshot.documentID]["quantity"];
           a++;
           dynamic price=widget.documentSnapshot.data[ModelFoodItem.price];
           dynamic b=map[widget.documentSnapshot.documentID]["totalPrice"];
           b=b+price;
           map[widget.documentSnapshot.documentID]["quantity"]=a;
           map[widget.documentSnapshot.documentID]["totalPrice"]=b;
           widget.cart.value=map;
           widget.cart.notifyListeners();


         }
         else
           {
             print("else");

             Map <String,dynamic>map=widget.cart.value;
             map[widget.documentSnapshot.documentID]={'quantity':1,
             'name':widget.documentSnapshot.data[ModelFoodItem.name],
               'totalPrice':widget.documentSnapshot.data[ModelFoodItem.price],
               "pricePerunit":widget.documentSnapshot.data[ModelFoodItem.price],
             };
             widget.cart.value=map;
            widget.cart.notifyListeners();
           }
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Card(

              child: ListTile(
              leading: SizedBox(height: 100.0,width: 100,child: ClipRRect(child: CachedNetworkImage(imageUrl: "${widget.documentSnapshot.data[ModelFoodItem.image]}",fit: BoxFit.cover,),borderRadius: BorderRadius.circular(8.0),)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("${widget.documentSnapshot.data[ModelFoodItem.name]}",style: TextStyle(fontWeight: FontWeight.bold),),
                  new Text("${widget.documentSnapshot.data[ModelFoodItem.shortDescription]}",style: TextStyle(color: Colors.grey),)
                ],
              ),
              trailing: new Column(mainAxisAlignment: MainAxisAlignment.end,
               crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[new Text("Rs ${widget.documentSnapshot.data[ModelFoodItem.price]}")],
              ),
            ),),
          ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(child: new ItemCount(cart: widget.cart,documentSnapshot: widget.documentSnapshot,),alignment: Alignment.topRight,),
        ),
        ],
      ),
    );

  }

}
class ItemCount extends StatefulWidget {
  ValueNotifier <Map<String ,dynamic>>cart;
  DocumentSnapshot documentSnapshot;
  ItemCount({this.cart,this.documentSnapshot});



  @override
  _ItemCountState createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cart.addListener((){
      print("listener in food item");
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return (widget.cart.value.containsKey(widget.documentSnapshot.documentID))?Container(
      decoration: BoxDecoration(color: Colors.pink,shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text('${widget.cart.value[widget.documentSnapshot.documentID]['quantity']}',style: TextStyle(color: Colors.white),),
      ),
    ):new Container();
  }
}
