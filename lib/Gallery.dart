import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<GalleryPage> {
  var token, id;
  var total;
  var jsondata;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    token    = "Token "+await storage.read(key: 'token'); 

    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/gallery/", headers: <String, String>{'authorization':token});    
    var stringdata = (response.body);
    jsondata = json.decode(response.body);

    total = jsondata['count'];

    setState(() {
      token;
    });
  }
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _editProfile()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget _editTitleTextField(){
    return Container(
      height: 600.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: total,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          elevation: 50,
          child: Container(
            width: 160.0,
            child: Column(
              children: <Widget>[
                Image.network(jsondata['results'][i]['image'] ?? 'default', width:150),
              ],
            ),
          ),
        ),
      )
    );
  }
}
class _editProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editProfile>{ 
  var token, id;
  final storage = new FlutterSecureStorage();
  FocusNode myFocusNode = new FocusNode();
  final format = DateFormat("yyyy-MM-dd");
  File _image;
  TextEditingController titleController   = TextEditingController();
  TextEditingController descripController = TextEditingController();
  TextEditingController dateController    = TextEditingController();

  @override  
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: new Text('Gallery'),
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  } 
  Upload(String Title, String Description, String Date, File imageFile) async { 
    token = "Token "+await storage.read(key: 'token');
    id    = await storage.read(key: 'id');
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://139.59.66.2:9000/stapi/v1/gallery/");

    Map<String, String> headers = { "authorization": token};

    var request = new http.MultipartRequest("POST", uri);

    request.headers.addAll(headers);
    request.fields['user'] = id;
    request.fields['title'] = titleController.text;
    request.fields['content'] = descripController.text;
    request.fields['date'] = dateController.text;
    var multipartFile = new http.MultipartFile('image', stream, length,
      filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),

            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: TextField(
                controller: descripController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: 'Full Description',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),),
              Text('Date',style: TextStyle(color: Colors.black, fontSize: 15,),),
              DateTimeField(
                controller: dateController,
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                },
              ),
            ]),
            Container(
              // width: 50.0,
              // height: 50.0,
              margin: const EdgeInsets.only(left: 20.0, right: 185.0, top: 10,),
              child: RaisedButton(
                color: Colors.blue, 
                child: Text('CHOOSE IMAGE',style: TextStyle(color: Colors.white,fontSize: 15),),
                onPressed: () => {
                  _showPicker(this.context)
                },
              ),  
            ),
            new Divider(color: Colors.black),
            Container(
              width: 180.0,
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: RaisedButton(
                color: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 22),),
                onPressed: () => Upload(titleController.text, descripController.text, dateController.text, File(_image.path)),
              ),  
            ),  
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => GalleryPage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  } 
}