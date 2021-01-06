import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';

class SupportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<SupportPage> {
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _editsupport()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
class _editsupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editsupport>{ 
  FocusNode myFocusNode = new FocusNode();
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Message',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              // height: 70.0,
              margin: const EdgeInsets.only(left: 20.0, right: 200.0, top: 10,),
              child: RaisedButton(
                color: Colors.blue, 
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () => {},
              ),  
            ),
            Row(children: [
              new Container(
                margin: const EdgeInsets.only(left: 0.0, right: 280.0, top: 540,),
              ),
              ClipOval(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    // splashColor: Colors.red, // inkwell color
                    child: SizedBox(width: 65, height: 65, child: Icon(Icons.cancel, color: Colors.white)),
                    onTap: () {  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(builder: (context) => SupportPage()),  
                      );  
                    },
                  ),
                ),
              )
            ]),  
          ],
        ),
      ),
    );
  } 
}