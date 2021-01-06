import 'package:flutter/material.dart';  
import 'dart:async';
import 'home.dart';
import 'Gallery.dart';
import 'work_Posts.dart';
import 'profile.dart';
import 'support.dart';
import 'About.dart';
import 'login_screen.dart';
import 'contact.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NavDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NavDrawer>{
  var first;
  var mail;
  var token;
  final storage = new FlutterSecureStorage();
 
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{
    first  = await storage.read(key: 'first_name');
    mail   = await storage.read(key: 'email');
    token  = "Token "+await storage.read(key: 'token');
    setState(() {
      token;
    }); 
  }
  @override  
  Widget build(BuildContext context) {  
    return Drawer(
      child: new ListView( 
        children: <Widget>[
          new UserAccountsDrawerHeader(
            currentAccountPicture: new GestureDetector(
              onTap: () =>  Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => profilePage()),  
              ) ,
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://dyl80ryjxr1ke.cloudfront.net/external_assets/hero_examples/hair_beach_v1785392215/result.jpeg"),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            accountName: new Text(first ?? 'default', style: TextStyle(color: Colors.black),),
            accountEmail: new Text(mail ?? 'default', style: TextStyle(color: Colors.blue),),
          ),
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => HomePage()),  
              );  
            },  
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.collections, color: Colors.black),
            title: Text('Gallery', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => GalleryPage()),  
              );  
            },  
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.work, color: Colors.black),
            title: Text('Work', style: TextStyle(color: Colors.black, fontSize: 15),),
             onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => workPostPage()),  
              );  
            },
          ),
          new Divider(),
          new ListTile( 
            leading: Icon(Icons.person, color: Colors.black), 
            title: Text('Profile', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => profilePage()),  
              );  
            },  
          ), 
          new Divider(),   
          new ListTile(  
            leading: Icon(Icons.local_phone , color: Colors.black),
            title: Text('Contact', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => contactPage()),  
              );  
            },
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Support', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => SupportPage()),  
              );  
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(Icons.search, color: Colors.black), 
            title: Text('About', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => AboutPage()),  
              );  
            },
          ),
          new Divider(), 
          new ListTile(  
            leading: Icon(Icons.power_settings_new, color: Colors.black),
            title: Text('Logout', style: TextStyle(color: Colors.black, fontSize: 20),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => LoginPage()),  
              );  
            },  
          ),
        ],  
      ),
    );
  }
} 