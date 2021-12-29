import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';
import 'package:flutter_project/views/adminView/SignUpView.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MainView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _myIdController=TextEditingController();
  final _myPwdController=TextEditingController();

  final dbaHelper = Db_AdminHelper.instance;



  Login() {
    String id=_myIdController.text;
    String password=_myPwdController.text;

    if(id.isEmpty){
      Fluttertoast.showToast(
          msg: "Pls enter ID",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else if(password.isEmpty){
      Fluttertoast.showToast(
          msg: "Pls enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      _login(id,password);
    }
  }

  @override
  void dispose(){
    _myIdController.dispose();
    _myPwdController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60,),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/login.png"),
                  radius: 50,
                ),
                SizedBox(height: 10.0),
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
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      hintText: "Admin Id",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: _myPwdController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "PassWord",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      Login();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color:Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color:Colors.green,
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Are you a new admin ?"),
                        FlatButton(
                           textColor: Colors.green,
                          child: Text("signup"),
                          onPressed: (){
                             Navigator.push(context,
                             MaterialPageRoute(builder: (_)=>SignUpView()));
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(String id,String pwd) async{
    Map<String,dynamic> row={
        Db_AdminHelper.Id : id,
        Db_AdminHelper.Password : pwd
    };

    final allRows = await dbaHelper.queryAdmin();
    print('query all rows:');
    allRows.forEach(print);

    await dbaHelper.getAdmin(row).then((value) { if (value == null) {
      Fluttertoast.showToast(
        msg: "Admin does not exist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
      );
    } else {
      Navigator.push(context,
      MaterialPageRoute(builder: (_)=>MainView()));
    }
    });


  }
}

