import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class contactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<contactPage> {
  var token, id;
  final storage = new FlutterSecureStorage();
  FocusNode myFocusNode = new FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phnController  = TextEditingController();
  TextEditingController msgController  = TextEditingController();
  TextEditingController subController  = TextEditingController();

  Upload(String name,String mail,String phn,String sub,String msg) async {
    id  = await storage.read(key: 'id');
    Map data = {
      'user': id,
      'name': name,
      'email':  mail,
      'mobile': phn,
      'subject': sub,
      'message': msg,
    };
    token    = "Token "+await storage.read(key: 'token');

    var jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/contact/", body: data, headers: <String, String>{'authorization':token});
    var stringData = (response.body);
    print(stringData);
    jsonData = json.decode(response.body);
  }
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Contact us', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  hintText: 'Name',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: mailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  hintText: 'Email',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                // initialValue: "0",
                controller: phnController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'phone',
                  // prefixIcon: Text("Phone",style: TextStyle(color: Colors.black, fontSize: 15,),)
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            //   child: TextField(
            //     controller: phnController,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
            //       labelText: 'Phone',
            //       labelStyle: TextStyle(
            //         color: myFocusNode.hasFocus ? Colors.red : Colors.black
            //       )
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: subController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  hintText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
                  hintText: 'Message',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              // height: 70.0,
              margin: const EdgeInsets.only(left: 200.0, right: 20.0, top: 10,),
              child: RaisedButton(
                color: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () => Upload(nameController.text, mailController.text, phnController.text, subController.text, msgController.text),
              ),  
            ), 
          ],
        ),
      ),
    );
  }
}