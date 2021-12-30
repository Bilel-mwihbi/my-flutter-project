import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MainView.dart';

class EditComponent extends StatefulWidget {
  Map<String, dynamic>  content;

  EditComponent({Key? key,required this.content}) : super(key: key);

  @override
  _EditComponentState createState() => _EditComponentState();
}

class _EditComponentState extends State<EditComponent> {

  final componentRef = TextEditingController();
  final quantity=TextEditingController();

  final dbaHelper = Db_AdminHelper.instance;

  var SelectedValue;

  @override
  void initState(){
    super.initState();
    componentRef.text=widget.content["component_name"];
    quantity.text=widget.content["qte"].toString();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_)=>MainView()));
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: componentRef,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reference'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Quantity'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    _update();
                  },
                  child: Text(
                    "update",
                    style: TextStyle(color:Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color:Colors.green,
                    borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  _update() async{
    Map<String, dynamic> row = {
      Db_AdminHelper.ComponentId :widget.content["component_id"],
      Db_AdminHelper.ComponentName : componentRef.text,
      Db_AdminHelper.quantity :int.parse(quantity.text)
    };

    try {
      final rowsAffected = await dbaHelper.updateComponent(row);
      if (rowsAffected >0) {
        Fluttertoast.showToast(
            msg: "update successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }
    catch(error) {
      print(error);
      Fluttertoast.showToast(
          msg: "error occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }

  }
  @override
  void dispose() {
    componentRef.dispose();
    quantity.dispose();
    super.dispose();
  }
}
