import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';

import 'MainView.dart';

class EditComponent extends StatefulWidget {
  const EditComponent({Key? key}) : super(key: key);

  @override
  _EditComponentState createState() => _EditComponentState();
}

class _EditComponentState extends State<EditComponent> {

  final componentRef = TextEditingController();
  final quantity=TextEditingController();

  final dbaHelper = Db_AdminHelper.instance;

  var SelectedValue;
  late List<String> myList;

  late List<Map<String,dynamic>> lists;

  @override
  void initState(){
    super.initState();
    myList=[];
    _getCategory();
  }

  _getCategory() async {

    List<String> items=[];
    await dbaHelper.getAllCat().then((value) {
      for (var i = 0; i < value.length; i++) {
        items.add(value[i]['category_name']);
      }
    }
    );
    myList=items;
    setState(() {

    });
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: componentRef,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reference'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Quantity'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:DropdownButton<String>(
                  hint: Text('Select category'),
                  value: null,
                  onChanged:(newValue){
                    setState(() {
                      SelectedValue=newValue.toString();
                      print(SelectedValue);
                    });
                  },
                  items: myList.map<DropdownMenuItem<String>>((ValueItem){
                    return DropdownMenuItem<String>(
                        value: ValueItem,
                        child:Text(
                          ValueItem,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}
