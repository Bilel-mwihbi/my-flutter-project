import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {

  final componentId= TextEditingController();
  final componentRef = TextEditingController();
  final quantity=TextEditingController();

  final dbaHelper = Db_AdminHelper.instance;

  var SelectedValue;

  late List<String> myList;

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
    print(myList);
    return Scaffold(

      appBar: AppBar(
        title: Text("Add new Component"),),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60,),
                  Image.asset("assets/images/component.png",
                    height: 125,
                    width:125 ,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: componentId,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color:Colors.black54),
                        ),
                        prefixIcon: Icon(Icons.room_preferences_outlined),
                        hintText: "Component Id",
                        fillColor: Colors.grey[300],

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 5.0),
                    child: TextFormField(
                      controller: componentRef,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        hintText: "Ref",
                        fillColor: Colors.grey[300],

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 5.0),
                    child: TextFormField(
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        prefixIcon: Icon(Icons.confirmation_number_outlined),
                        hintText: "Quantity",
                        fillColor: Colors.grey[300],

                      ),
                    ),
                  ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
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
                        )
              ),

                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        add();
                      },
                      child: Text(
                        "Add",
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
        ),
      );
  }

  Future<void> add() async {
    String id = componentId.text;
    String ref = componentRef.text;
    String qte = quantity.text;

    if (id.isEmpty) {
      Fluttertoast.showToast(
          msg: "Pls enter ID of the component",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else if (ref.isEmpty) {
      Fluttertoast.showToast(
          msg: "Pls enter Reference",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else if (qte.isEmpty) {
      Fluttertoast.showToast(
          msg: "Pls enter Quantity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else if(SelectedValue == null){
      Fluttertoast.showToast(
          msg: "pls chose category",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
    else {
      var value= await dbaHelper.getIdCategory(SelectedValue);
      insert(int.parse(qte),value![0]['category_id']);
    }
  }


  void insert(int qte,String category) async{



    Map<String, dynamic> row = {
      Db_AdminHelper.ComponentId: componentId.text,
      Db_AdminHelper.ComponentName: componentRef.text,
      Db_AdminHelper.quantity: qte,
      Db_AdminHelper.cate: category
    };

    try {
      final id = await dbaHelper.insertComponent(row);
      Fluttertoast.showToast(
          msg: "Successfully Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Error pls verify your id ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

/*
    await dbaHelper.getIdCategory(category).then((value) {
      if (value == null) {
        Fluttertoast.showToast(
            msg: "category does not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        print(value[0]['category_id']);

        Map<String, dynamic> row = {
          Db_AdminHelper.ComponentId: componentId.text,
          Db_AdminHelper.ComponentName: componentRef.text,
          Db_AdminHelper.quantity: qte,
          Db_AdminHelper.date_accui:"hello",
          Db_AdminHelper.date_retour:"hello",
          Db_AdminHelper.cate:value[0]['category_id']

        };

        try {
          final id =  dbaHelper.insertComponent(row);
          Fluttertoast.showToast(
              msg: "Successfully Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );

          final allRows =  dbaHelper.queryComponent();
          allRows.then((value) => print(value));

        }
        catch (error) {
          print(error);
          Fluttertoast.showToast(
              msg: "Error pls verify your id ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
    });


 */


    }
  @override
  void dispose() {
    componentId.dispose();
    componentRef.dispose();
    quantity.dispose();
    super.dispose();
  }
}




