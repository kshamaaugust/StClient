import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/widgets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

class workPostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<workPostPage> {
  var token;
  var id;
  var jsondata;
  var total;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    token    = "Token "+await storage.read(key: 'token'); 

    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/work/", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringdata = (response.body);
    print(stringdata);
    jsondata = json.decode(response.body);

    total = jsondata['count'];

    var title = jsondata['results'][0]['title'];
    print(title.toString());

    setState(() {
      token;
    });
  }

  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('All Users', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _addProfile()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget _editTitleTextField(){
    return Container(
      padding: EdgeInsets.fromLTRB(20,15,20,0),
      height: 560.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: total,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          // elevation: 50,
          child: Container(
            width: 190.0,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text(jsondata['results'][i]['profession'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 22),),
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text(jsondata['results'][i]['title'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),                
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text(jsondata['results'][i]['content'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text('Job expire:- ' +jsondata['results'][i]['expire'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),                
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                FlatButton(
                  color: Colors.blue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Text("View", style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.push(  
                      context,  
                      MaterialPageRoute(builder: (context) => _viewProfile()),  
                    );  
                  },
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _viewProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ViewProfileState();
}
class _ViewProfileState extends State<_viewProfile>{ 
  var token;
  var id;
  var jsondata;
  var title, cntent, agency, sdate, edate, expire, vacancy, profes, jtype, ptype, shift, currency, address, local, city, state;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    token    = "Token "+await storage.read(key: 'token'); 
    id       = await storage.read(key: 'id');
    print("id is" +id);
    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/work/"+id+"/", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringdata = (response.body);
    print(stringdata);
    jsondata = json.decode(response.body);
    
    title = (jsondata['title']);
    cntent = (jsondata['content']);
    agency = (jsondata['agency']);
    sdate = (jsondata['sdate']);
    edate = (jsondata['edate']);
    expire = (jsondata['expire']);
    vacancy = (jsondata['vacancy']);
    profes = (jsondata['profession']);
    jtype = (jsondata['jobtype']);
    ptype = (jsondata['paytype']);
    shift = (jsondata['shift']);
    currency = (jsondata['currency']);
    address = (jsondata['address']);
    local = (jsondata['locality']);
    city = (jsondata['city']);
    state = (jsondata['state']);

    setState(() {
      token;
    });
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Work Posts', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget _editTitleTextField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Title :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(title.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Job Description :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(cntent.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Agency :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(agency.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Start Date :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: new Text(sdate.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('End Date :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(edate.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Job Expire :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(expire.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Vacancy :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(vacancy.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Professional :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(profes.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Job Type :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(jtype.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Pay type :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(ptype.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Shift :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(shift.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Currency :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(currency.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Address :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(address.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Locality :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(local.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('City :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(city.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('State :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(state.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          width: 180.0,
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: RaisedButton(
            color: Colors.blue, 
            child: Text('UPDATE',style: TextStyle(color: Colors.white,fontSize: 22),),
            onPressed: () {  
              Navigator.push(  
                this.context,  
                MaterialPageRoute(builder: (context) => _editProfile()),  
              );  
            },       
          ),  
        ),
      ]),
    ]);
  }   
}
class _addProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_addProfile>{ 
  FocusNode myFocusNode = new FocusNode();
  final storage = new FlutterSecureStorage();
  var token;
  var id;
  var workid;
  var jsonData;

  String _myActivity;
  String _myActivityResult;
  String _myActivity1;
  String _myActivityResult1;
  String _myActivity2;
  String _myActivityResult2;
  String _myActivity3; 
  String _myActivityResult3;
  String _myActivity4;
  String _myActivityResult4;
  String _myActivity5;
  String _myActivityResult5;

  final formKey = new GlobalKey<FormState>();
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  final formKey5 = new GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController titleController     = TextEditingController();
  TextEditingController descripController   = TextEditingController();
  TextEditingController sdateController        = TextEditingController();
  TextEditingController edateController        = TextEditingController();
  TextEditingController jobController          = TextEditingController();
  TextEditingController vacancyController      = TextEditingController();
  TextEditingController addressController      = TextEditingController();
  TextEditingController localityController     = TextEditingController();
  TextEditingController cityController         = TextEditingController();
  TextEditingController stateController        = TextEditingController();
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    _myActivity1 = '';
    _myActivityResult1 = '';
    _myActivity2 = '';
    _myActivityResult2 = '';
    _myActivity3 = '';
    _myActivityResult3 = '';
    _myActivity4 = '';
    _myActivityResult4 = '';
    _myActivity5 = '';
    _myActivityResult5 = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    var form1 = formKey1.currentState;
    var form2 = formKey2.currentState;
    var form3 = formKey3.currentState;
    var form4 = formKey4.currentState;
    var form5 = formKey5.currentState;
    setState(() {
      _myActivityResult = _myActivity;
      print(_myActivityResult);
    });
    setState(() {
      _myActivityResult1 = _myActivity1;
      print(_myActivityResult1);
    });
    setState(() {
      _myActivityResult2 = _myActivity2;
      print(_myActivityResult2);
    });
    setState(() {
      _myActivityResult3 = _myActivity3;
      print(_myActivityResult3);
    });
    setState(() {
      _myActivityResult4 = _myActivity4;
      print(_myActivityResult4);
    });
    setState(() {
      _myActivityResult5 = _myActivity5;
      print(_myActivityResult5);
    });
  }
  Upload(String Title,String Descrip,String agency,String sdate, String edate, String expire, String vacancy, String profession, String jobtype,String paytype,String shift,String currency,String address,String locality,String city,String state) async {
    print("hello...");
    id  = await storage.read(key: 'id');
    Map data = {
      'client': id,
      'title': Title,
      'content': Descrip,
      'agency':  agency,
      'sdate': sdate,
      'edate': edate,
      'expire': expire,
      'vacancy': vacancy,
      'profession': profession,
      'jobtype': jobtype,
      'paytype': paytype,
      'shift': shift,
      'currency': currency,
      'address': address,
      'locality': locality,
      'city': city,
      'state': state,
      'service': 'Client'
    };
    token    = "Token "+await storage.read(key: 'token');
    id  = await storage.read(key: 'id');

    jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/work/", body: data, headers: <String, String>{'authorization':token});
    print(response.statusCode);
    var stringData = (response.body);
    print(stringData);
    jsonData = json.decode(response.body);
    print(jsonData);
     // workid = (jsonData['id']);
     //  print("workid is..." +workid);
     print(jsonData.length);
    for(int x=0;x< jsonData.length; x++){
      workid = (jsonData[x]['id']);
      print("workid is..." +workid);
    }

    await storage.write(key: 'id' , value: workid);
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Work Posts', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: descripController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Job Description',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey,
                child: Column(
                  key: formKey,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16), 
                      child: DropDownFormField(
                        titleText: 'Agency',
                        hintText: 'Select Agency',
                        value: _myActivity,
                        onSaved: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "  ",
                            "value": "  ",
                          },
                          {
                            "display": "Security Troops",
                            "value": "Security Troops",
                          },
                          {
                            "display": "babafurnitur works",
                            "value": "babafurnitur works",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
              Text('Start Date'),
              DateTimeField(
                controller: sdateController,
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
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
              Text('End Date'),
              DateTimeField(
                controller: edateController,
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: jobController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Job Expire',
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
                controller: vacancyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
                  prefixIcon: Text("Vacancy",style: TextStyle(color: Colors.black), )
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey1,
                child: Column(
                  key: formKey1,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Professional',
                        hintText: 'Select Type',
                        value: _myActivity1,
                        onSaved: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Watchman",
                            "value": "Watchman",
                          },
                          {
                            "display": "Gunman",
                            "value": "Gunman",
                          },
                          {
                            "display": "Valet",
                            "value": "Valet",
                          },
                          {
                            "display": "Bouncer",
                            "value": "Bouncer",
                          },
                          {
                            "display": "Bodyguard",
                            "value": "Bodyguard",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey2,
                child: Column(
                  key: formKey2,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Job Type',
                        hintText: 'Select Type',
                        value: _myActivity2,
                        onSaved: (value) {
                          setState(() {
                            _myActivity2 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity2 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Fulltime",
                            "value": "Fulltime",
                          },
                          {
                            "display": "Parttime",
                            "value": "Parttime",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey3,
                child: Column(
                  key: formKey3,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Pay Type',
                        hintText: 'Select Type',
                        value: _myActivity3,
                        onSaved: (value) {
                          setState(() {
                            _myActivity3 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity3 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Hour",
                            "value": "Hour",
                          },
                          {
                            "display": "Day",
                            "value": "Day",
                          },
                          {
                            "display": "Month",
                            "value": "Month",
                          },
                          {
                            "display": "Year",
                            "value": "Year",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey4,
                child: Column(
                  key: formKey4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Shift',
                        hintText: 'Select Type',
                        value: _myActivity4,
                        onSaved: (value) {
                          setState(() {
                            _myActivity4 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity4 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Both",
                            "value": "Both",
                          },
                          {
                            "display": "Day",
                            "value": "Day",
                          },
                          {
                            "display": "Night",
                            "value": "Night",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey5,
                child: Column(
                  key: formKey5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Currecncy',
                        hintText: 'Select Type',
                        value: _myActivity5,
                        onSaved: (value) {
                          setState(() {
                            _myActivity5 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity5 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "INR",
                            "value": "Fulltime",
                          },
                          {
                            "display": "USD",
                            "value": "Parttime",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: localityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Locality',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: cityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'City',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: stateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'State',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              width: 180.0,
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: RaisedButton(
                color: Colors.blue, 
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 22),),
                onPressed: () => Upload(titleController.text, descripController.text, _myActivityResult, sdateController.text, edateController.text, jobController.text, vacancyController.text, _myActivityResult1, _myActivityResult2, _myActivityResult3, _myActivityResult4, _myActivityResult5, addressController.text, localityController.text, cityController.text, stateController.text),
              ),  
            ),
          ],
        ),
      ),
    );
  } 
}
class _editProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _editWorkState();
}
class _editWorkState extends State<_editProfile>{
  FocusNode myFocusNode = new FocusNode();
  final storage = new FlutterSecureStorage();
  var token;
  var id;
  var workid;
  var jsonData;

  String _myActivity;
  String _myActivityResult;
  String _myActivity1;
  String _myActivityResult1;
  String _myActivity2;
  String _myActivityResult2;
  String _myActivity3; 
  String _myActivityResult3;
  String _myActivity4;
  String _myActivityResult4;
  String _myActivity5;
  String _myActivityResult5;

  final formKey = new GlobalKey<FormState>();
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  final formKey5 = new GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController titleController     = TextEditingController();
  TextEditingController descripController   = TextEditingController();
  TextEditingController sdateController        = TextEditingController();
  TextEditingController edateController        = TextEditingController();
  TextEditingController jobController          = TextEditingController();
  TextEditingController vacancyController      = TextEditingController();
  TextEditingController addressController      = TextEditingController();
  TextEditingController localityController     = TextEditingController();
  TextEditingController cityController         = TextEditingController();
  TextEditingController stateController        = TextEditingController();
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    _myActivity1 = '';
    _myActivityResult1 = '';
    _myActivity2 = '';
    _myActivityResult2 = '';
    _myActivity3 = '';
    _myActivityResult3 = '';
    _myActivity4 = '';
    _myActivityResult4 = '';
    _myActivity5 = '';
    _myActivityResult5 = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    var form1 = formKey1.currentState;
    var form2 = formKey2.currentState;
    var form3 = formKey3.currentState;
    var form4 = formKey4.currentState;
    var form5 = formKey5.currentState;
    setState(() {
      _myActivityResult = _myActivity;
      print(_myActivityResult);
    });
    setState(() {
      _myActivityResult1 = _myActivity1;
      print(_myActivityResult1);
    });
    setState(() {
      _myActivityResult2 = _myActivity2;
      print(_myActivityResult2);
    });
    setState(() {
      _myActivityResult3 = _myActivity3;
      print(_myActivityResult3);
    });
    setState(() {
      _myActivityResult4 = _myActivity4;
      print(_myActivityResult4);
    });
    setState(() {
      _myActivityResult5 = _myActivity5;
      print(_myActivityResult5);
    });
  }
  Upload(String Title,String Descrip,String agency,String sdate, String edate, String expire, String vacancy, String profession, String jobtype,String paytype,String shift,String currency,String address,String locality,String city,String state) async {
    print("hello...");
    id  = await storage.read(key: 'id');
    Map data = {
      'client': id,
      'title': Title,
      'content': Descrip,
      'agency':  agency,
      'sdate': sdate,
      'edate': edate,
      'expire': expire,
      'vacancy': vacancy,
      'profession': profession,
      'jobtype': jobtype,
      'paytype': paytype,
      'shift': shift,
      'currency': currency,
      'address': address,
      'locality': locality,
      'city': city,
      'state': state,
      'service': 'Client'
    };
    token    = "Token "+await storage.read(key: 'token');
    id  = await storage.read(key: 'id');

    jsonData = null;
    var response = await http.patch("http://139.59.66.2:9000/stapi/v1/work/", body: data, headers: <String, String>{'authorization':token});
    print(response.statusCode);
    var stringData = (response.body);
    print(stringData);
    jsonData = json.decode(response.body);
    print(jsonData);

    for(int x=0;x< jsonData.length; x++){
      var workid = (jsonData['results'][x]['id']);
      print("work id is after edit" +workid);
    }
    // await storage.write(key: 'id' , value: workid.toString());
  }
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Update', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: descripController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Job Description',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey,
                child: Column(
                  key: formKey,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16), 
                      child: DropDownFormField(
                        titleText: 'Agency',
                        hintText: 'Select Agency',
                        value: _myActivity,
                        onSaved: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "  ",
                            "value": "  ",
                          },
                          {
                            "display": "Security Troops",
                            "value": "Security Troops",
                          },
                          {
                            "display": "babafurnitur works",
                            "value": "babafurnitur works",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
              Text('Start Date'),
              DateTimeField(
                controller: sdateController,
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
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
              Text('End Date'),
              DateTimeField(
                controller: edateController,
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: jobController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Job Expire',
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
                controller: vacancyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
                  prefixIcon: Text("Vacancy",style: TextStyle(color: Colors.black), )
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey1,
                child: Column(
                  key: formKey1,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Professional',
                        hintText: 'Select Type',
                        value: _myActivity1,
                        onSaved: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Watchman",
                            "value": "Watchman",
                          },
                          {
                            "display": "Gunman",
                            "value": "Gunman",
                          },
                          {
                            "display": "Valet",
                            "value": "Valet",
                          },
                          {
                            "display": "Bouncer",
                            "value": "Bouncer",
                          },
                          {
                            "display": "Bodyguard",
                            "value": "Bodyguard",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey2,
                child: Column(
                  key: formKey2,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Job Type',
                        hintText: 'Select Type',
                        value: _myActivity2,
                        onSaved: (value) {
                          setState(() {
                            _myActivity2 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity2 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Fulltime",
                            "value": "Fulltime",
                          },
                          {
                            "display": "Parttime",
                            "value": "Parttime",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey3,
                child: Column(
                  key: formKey3,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Pay Type',
                        hintText: 'Select Type',
                        value: _myActivity3,
                        onSaved: (value) {
                          setState(() {
                            _myActivity3 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity3 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Hour",
                            "value": "Hour",
                          },
                          {
                            "display": "Day",
                            "value": "Day",
                          },
                          {
                            "display": "Month",
                            "value": "Month",
                          },
                          {
                            "display": "Year",
                            "value": "Year",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey4,
                child: Column(
                  key: formKey4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Shift',
                        hintText: 'Select Type',
                        value: _myActivity4,
                        onSaved: (value) {
                          setState(() {
                            _myActivity4 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity4 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Both",
                            "value": "Both",
                          },
                          {
                            "display": "Day",
                            "value": "Day",
                          },
                          {
                            "display": "Night",
                            "value": "Night",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container( 
              child: Form(
                key: formKey5,
                child: Column(
                  key: formKey5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropDownFormField(
                        // controller: titleController,
                        titleText: 'Currecncy',
                        hintText: 'Select Type',
                        value: _myActivity5,
                        onSaved: (value) {
                          setState(() {
                            _myActivity5 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity5 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "INR",
                            "value": "Fulltime",
                          },
                          {
                            "display": "USD",
                            "value": "Parttime",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: localityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Locality',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: cityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'City',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: stateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'State',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              width: 180.0,
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: RaisedButton(
                color: Colors.blue, 
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 22),),
                onPressed: () => Upload(titleController.text, descripController.text, _myActivityResult, sdateController.text, edateController.text, jobController.text, vacancyController.text, _myActivityResult1, _myActivityResult2, _myActivityResult3, _myActivityResult4, _myActivityResult5, addressController.text, localityController.text, cityController.text, stateController.text),
              ),  
            ),
          ],
        ),
      ),
    );
  }
}