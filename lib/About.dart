import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<AboutPage> {
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('About', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body:new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField()
          ],
        ),
      ),
    );
  }
  Widget _editTitleTextField(){
    return Column(children: <Widget>[
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 200,
            width: 350,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                      child: Center(child: Text('Experienced Guards', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: Text('Security Troops company provides the physical', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('security protection services to residential,', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('commercial, construction and industrial sites', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('within the India.', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                    
              ]),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 150,
            width: 350,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                      child: Center(child: Text('Effective Price', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: Text('ST provides you best security services at very', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('effective price that fits your pockets.', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                    
              ]),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 200,
            width: 350,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                      child: Center(child: Text('Genuine Review', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: Text('Security Troops services and its online platform', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('enable us to provide you with just right', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('solution to meet the requirements of the industry.', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                    
              ]),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 200,
            width: 350,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                      child: Center(child: Text('Commitment to Safety', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: Text('Through our experties, ingrity, dignity,', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('Commitment and excellence in all we do, we are', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('decided to provide quality service to our sociaty', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('in an effective responsive and professional way', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                    
              ]),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 200,
            width: 350,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                      child: Center(child: Text('One Stop for Security', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: Text('Security Troops is the one stop online platform for', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('you, where you can get/book best security', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ), 
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text('protection service for you', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                   
              ]),
            ),
          ),
        ],
      ),
    ]);
  }
}