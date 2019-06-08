import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Withdraw extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: <Widget>[
          Column(
            children: <Widget>[
              new Row(children: <Widget>[
                Expanded(child: new Container(height: 120,color: Color.fromRGBO(72, 21, 88, 1),))
              ],)
            ],
          ),

          //Rest of the Widget
          Align(child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: ListView(shrinkWrap: true,

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                            "https://www.kiplinger.com/kipimages/pages/19045.jpg"),
                      ),
                    ],
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


                //image name and number end


                Padding(
                  padding: const EdgeInsets.only(top:28.0,left: 8.0),
                  child: new Text('Balance:',style: TextStyle(color: Color.fromRGBO(72, 21, 88, 1),fontSize: 24,fontWeight: FontWeight.bold),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:2.0),
                  child: Center(child: new Text('240000 rs',style: TextStyle(color: Color.fromRGBO(72, 21, 88, 1),fontSize: 34,fontWeight: FontWeight.bold),)),
                ),


                //recivers number and amount


                Padding(
                  padding: const EdgeInsets.only(top:28.0,left: 10,right: 10),
                  child: new TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(labelText: "Amount",border: OutlineInputBorder()),),
                ),



                //recivers number and amount



                //pin and Button
                Padding(
                  padding: const EdgeInsets.only(left:18.0,top: 54,right: 18),
                  child: Center(child: new Text("PIN",style: TextStyle(color:Color.fromRGBO(72, 21, 88, 1) ,fontSize: 16,fontWeight: FontWeight.normal),),),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new PinCodeTextField(

                          pinBoxWidth: 13,
                          pinBoxHeight: 13,
                          hideCharacter:false,
                          highlight: true,
                          highlightColor: Colors.deepPurple,
                          autofocus: true,
                          maxLength: 6,
                          maskCharacter: ".",



                        ),
                      ),
                    ),
                  ],
                ),









                //pin and Button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: new RaisedButton(onPressed: (){},color:Color.fromRGBO(72, 21, 88, 1) ,child: Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom: 12.0,right: 20,left: 20),
                        child: new Text("Withdraw",style: TextStyle(color: Colors.white ,fontSize: 18),),
                      ),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),),
                    ),
                  ],
                ),

              ],

            ),
          ),


            alignment: Alignment.topCenter,),


          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top:29.0,left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    new Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Withdraw",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                    ),
                  ],
                ),
              ))

          //Rest of the Widget
        ],
      ),
    );
  }
}
