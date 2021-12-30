import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final _myIdController = TextEditingController();
  final _myCategoryNameController = TextEditingController();
  final dbaHelper = Db_AdminHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Category"),),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _myIdController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        prefixIcon: Icon(Icons.adb_outlined),
                        hintText: "Category Ref",
                        fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _myCategoryNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        prefixIcon: Icon(Icons.all_inclusive_outlined),
                        hintText: "Category Name",
                        fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        add();
                      },
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    String id = _myIdController.text;
    String ref = _myCategoryNameController.text;

    if (id.isEmpty) {
      Fluttertoast.showToast(
          msg: "Pls enter ID of the category",
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
    } else {
      _insert();
    }
  }

  void _insert() async {
    Map<String, dynamic> row = {
    Db_AdminHelper.CategoryId: _myIdController.text,
    Db_AdminHelper.CategoryName: _myCategoryNameController.text
    };


    try {
      final id = await dbaHelper.insertCategory(row);
      if (id  >0) {
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
    _myIdController.dispose();
    _myCategoryNameController.dispose();
    super.dispose();
  }
}








