import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'work_Posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<HomePage> {
  var token;
  var work;
  var running;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    token    = "Token "+await storage.read(key: 'token'); 

    var jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/home/", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringdata = (response.body);
    print(stringdata);
    jsondata = json.decode(response.body);

    work = jsondata['work'];
    print(work);

    running = jsondata['running'];
    print(running);

    setState(() {
      token;
    });
  }
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Column(children: <Widget>[
        Row(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 140,
            width: 160,
            child: Card(
              color: Colors.blue,
              child: InkWell(
                onTap: () {  
                  Navigator.push(  
                    context,  
                    MaterialPageRoute(builder: (context) => workPostPage()),  
                  );  
                },
                child: Column(children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.person, color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        child: Center(child: Text(work.toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 18),),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,20,0,20),
                        child: Text('Total Work', style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 140,
            width: 160,
            child: Card(
              color: Colors.black,
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Center(child: Text(running.toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 18),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20,20,0,20),
                      child: Text('Active Duties', style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        ]),
        Row(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,20,0,0),
            height: 150,
            child: Card(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,170,0),
                      child: Center(child: Text('Active Duties', style: TextStyle(color: Colors.black, fontSize: 20),),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,40,0),
                      child: Text('Check All yours all Work Diaries and Track', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0,0,125,0),
                      child: Text('associated Professionals.', style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                  ],
                ),                    
              ]),
            ),
          ),
        ]),
      ]),
    );
  }
}