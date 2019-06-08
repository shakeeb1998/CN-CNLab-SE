import 'package:flutter/material.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("QR Payment"),
        backgroundColor: Color.fromRGBO(72, 21, 88, 1),
      ),
      backgroundColor: Color.fromRGBO(237, 237, 237, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: new Card(
            shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  //
                  Padding(
                    padding: const EdgeInsets.only(top:18.0,right: 8,left: 8,bottom:0),
                    child: new Text('Merchant Name',style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 22,fontWeight: FontWeight.bold),),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: new Text('XYZ Resturant',style: TextStyle(fontSize: 16),),
                  )),
                  new Text("Merchant City",style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 22,fontWeight: FontWeight.bold),),
                  Center(child: new Text("Karachi",style: TextStyle(fontSize: 16),),),
                  Padding(
                    padding: const EdgeInsets.only(top:18.0,right: 40,left: 40,bottom: 18),
                    child: new TextField(decoration: InputDecoration(labelText: 'Amount',border: OutlineInputBorder()),keyboardType: TextInputType.number,),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: new RaisedButton(onPressed: (){},color:Color.fromRGBO(72, 21, 88, 1) ,child: Padding(
                          padding: const EdgeInsets.only(top:12.0,bottom: 12.0,right: 20,left: 20),
                          child: new Text("Pay",style: TextStyle(color: Colors.white ,fontSize: 18),),
                        ),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
