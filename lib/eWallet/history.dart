import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Transaction History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
      ),
      body: new Column(
        children: <Widget>[
          //total deposits and with draws

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(
                      "Total Deposit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    new Text("+120566",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 16))
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text(
                      "Withdraw",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    new Text("-20566",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 16))
                  ],
                ),
              ],
            ),
          ),

          //total deposits and with draws

          //History
          Expanded(
            child: new Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Color.fromRGBO(72, 21, 88, 1)),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(18),
                      children: <Widget>[

                        new Card(
                          elevation: 14,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(
                              
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                      new Text("Time: 12:32:30"),
                                      new Text("Date: 12/2/19")
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Transaction Type: Withdraw",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Amount: 12000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text('TransactionID: QEcyvhIFC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Agents Phone: 03430000000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),

                        new Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(

                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("Time: 12:32:30"),
                                    new Text("Date: 12/2/19")
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Transaction Type: Withdraw",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Amount: 12000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text('TransactionID: QEcyvhIFC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Agents Phone: 03430000000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),



                        new Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(

                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("Time: 12:32:30"),
                                    new Text("Date: 12/2/19")
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Transaction Type: Withdraw",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Amount: 12000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text('TransactionID: QEcyvhIFC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Agents Phone: 03430000000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),



                        new Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(

                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("Time: 12:32:30"),
                                    new Text("Date: 12/2/19")
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Transaction Type: Withdraw",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Amount: 12000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text('TransactionID: QEcyvhIFC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Agents Phone: 03430000000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),



                        new Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(

                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("Time: 12:32:30"),
                                    new Text("Date: 12/2/19")
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Transaction Type: Withdraw",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Amount: 12000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text('TransactionID: QEcyvhIFC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Agents Phone: 03430000000",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),



                      ],
                    ),
                  )
                ],
              ),
            ),
          )

          //History
        ],
      ),
    );
  }
}
