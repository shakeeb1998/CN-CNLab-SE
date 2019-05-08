import 'package:flutter/material.dart';
import 'package:on_day/SString.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckOut extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  ValueNotifier<Map<String,dynamic>> cart;
  CheckOut({this.cart,this.documentSnapshot}){
    print('qwerttty');
    print(cart);
  }

  @override
  _CheckOutState createState() => _CheckOutState(cart: cart);
}

class _CheckOutState extends State<CheckOut> {
  List <CartItem> list;
  ValueNotifier<Map<String,dynamic>> cart;
_CheckOutState({this.cart}){
  list=new List();
  for (String i in cart.value.keys)
    {
      print('worl');
      if(i=='s'|| i==ModelCartItem.subTotal)
        {
          continue;
        }
        else{

          list.add(new CartItem(cart: cart,itemId: i,));

      }
    }
}
  void _showDialog() {
    // flutter defined function
    bool placing=true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        SharedPreferences.getInstance().then((shared){
          Firestore.instance.collection("${ModelResturants.modelName}/${widget.documentSnapshot.documentID}/currentOrders").add(
            {
              'details':cart.value,
              "name":shared.getString(CnString.name),
              "email":shared.getString(CnString.email),
              'restID':widget.documentSnapshot.documentID,
              'uid':shared.getString(CnString.uid),
              "ack":false,
              'kitchen':false,
              "deliveryBoy":false,
              "paid":false,

            }
          ).then((docref){
            Firestore.instance.document("user/${shared.getString(CnString.uid)}/currentOrders/${docref.documentID}").setData(
                {
                  'details':cart.value,
                  "name":shared.getString(CnString.name),
                  "email":shared.getString(CnString.email),
                  'restID':widget.documentSnapshot.documentID,
                  "orderID":docref.documentID,
                  "restName":widget.documentSnapshot.data[ModelResturants.name],
                }
            ).then((val){
              List lp=new List.from(cart.value.keys);

              for(String i in lp)
                {
                  if(i=='s')
                    {
                      continue;
                    }
                    else{
                    cart.value.remove(i);
                  }
                }
                cart.notifyListeners();
              setState(() {
                placing=false;

              });
              Navigator.pop(context);
              Navigator.pop(context);
              print("new Cart");
              print(cart);

            });
          });
        });
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Placing Order"),
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
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Checkout"),
      backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4.0,
          child: ListView(
            children: <Widget>[
              new Column(
                children: list,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Divider(color: Colors.pink,),
              ),
              new ListTile(leading: new Text("SubTotal"),trailing: new TotalPrice(cart:cart),),
              new ListTile(leading: new Text("Delivery Fee"),trailing:(widget.documentSnapshot.data[ModelResturants.deliveryCharges]!=null)? new Text(widget.documentSnapshot.data[ModelResturants.deliveryCharges].toString()):new Text('0'),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Divider(color: Colors.pink,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(onPressed: ()=>_showDialog(),child:new Text("Place Order",style: TextStyle(color: Colors.white),),color: Colors.pink,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CartItem extends StatefulWidget {
  String itemId;
  ValueNotifier<Map<String,dynamic>> cart;

  CartItem({this.itemId,this.cart});
  @override
  _CartItemState createState() => _CartItemState(cart: cart,itemId: itemId);
}

class _CartItemState extends State<CartItem> {
  String itemId;
  ValueNotifier<Map<String,dynamic>> cart;

  _CartItemState({this.itemId,this.cart});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cart.addListener((){
      print("listener in cart item");
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    print('err');
    print(itemId);
    return (cart.value.containsKey(itemId))?ListTile(
      leading: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        InkWell(
            onTap: (){
              print("isddsf");
              Map <String,dynamic>map=cart.value;
              dynamic a=map[itemId]["quantity"];
              a--;
              if(a==0)
                {
                  map.remove(itemId);
                  cart.value=map;
                  cart.notifyListeners();
                  print("ssd");


                }
                else {
                  print('hello');
                dynamic price = map[itemId][ModelCartItem.pricePerunit];
                dynamic b = map[itemId]["totalPrice"];
                b = b - price;
                map[itemId]["quantity"] = a;
                map[itemId]["totalPrice"] = b;
                cart.value = map;
                cart.notifyListeners();
              }
            },
            child: new Icon(Icons.close,color: Colors.pink,)),
        new Text(cart.value[itemId][ModelCartItem.quantity].toString()),
        InkWell(child: new Icon(Icons.add,color: Colors.pink,),onTap: (){
          print("isddsf");
          Map <String,dynamic>map=cart.value;
          dynamic a=map[itemId]["quantity"];
          a++;
          dynamic price=map[itemId][ModelCartItem.pricePerunit];
          dynamic b=map[itemId]["totalPrice"];
          b=b+price;
          map[itemId]["quantity"]=a;
          map[itemId]["totalPrice"]=b;
          cart.value=map;
          cart.notifyListeners();
        },),

      ],
      ),
      title: new Text(cart.value[itemId][ModelCartItem.name]),
      trailing: new Text("Rs "+cart.value[itemId][ModelCartItem.totalPrice].toString()),
    ):new Container();
  }
  
}
class TotalPrice extends StatefulWidget {
  ValueNotifier<Map<String,dynamic>> cart;
  TotalPrice({this.cart});
  @override
  _TotalPriceState createState() => _TotalPriceState(cart: cart);
}

class _TotalPriceState extends State<TotalPrice> {
  ValueNotifier<Map<String,dynamic>> cart;
  _TotalPriceState({this.cart}){
    int total=0;
    for (String i in cart.value.keys)
    {
      print(i);
      if(i=='s'|| i==ModelCartItem.subTotal)
      {
        continue;
      }
      else{
        total+=cart.value[i][ModelCartItem.totalPrice];

      }
    }
    cart.value[ModelCartItem.subTotal]=total;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cart.addListener((){
      int total=0;
      for (String i in cart.value.keys)
      {
        if(i=='s'|| i==ModelCartItem.subTotal)
        {
          continue;
        }
        else{
          print("cureent")
          ;
          print(i);
          print(cart.value.keys);
          print(cart);
          total+=cart.value[i]['totalPrice'];

        }
      }
      cart.value[ModelCartItem.subTotal]=total;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Text("Rs "+cart.value[ModelCartItem.subTotal].toString());
  }
}

