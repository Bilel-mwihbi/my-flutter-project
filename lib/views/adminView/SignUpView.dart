import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginView.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

    final dbaHelper = Db_AdminHelper.instance;

   final _myIdController=TextEditingController();
   final _myNameController=TextEditingController();
   final _myEmailController=TextEditingController();
   final _myPwdController=TextEditingController();
   final _myCPwdController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60,),
                Image.asset("assets/images/login.png",
                  height: 125,
                  width:125 ,
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
                        borderSide: BorderSide(color:Colors.black54),
                      ),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Id",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _myNameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      prefixIcon: Icon(Icons.person_outlined),
                      hintText: "Name",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _myEmailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 5.0),
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
                      hintText: "Password",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _myCPwdController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color:Colors.black54),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Confirm password",
                      fillColor: Colors.grey[300],

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(color:Colors.white),
                    ),
                    onPressed: (){
                      signUp();
                    },
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
                        Text("Do you have an account ?"),
                        FlatButton(
                          textColor: Colors.green,
                          child: Text("sign in "),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>LoginView()));
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
    signUp(){
      String id=_myIdController.text;
      String name=_myNameController.text;
      String email=_myEmailController.text;
      String password=_myPwdController.text;
      String cpassword=_myCPwdController.text;

      if(id.isEmpty){
        Fluttertoast.showToast(
            msg: "pls enter ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0
        );
      } else if(name.isEmpty){
        Fluttertoast.showToast(
            msg: "pls enter name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }else if(email.isEmpty){
        Fluttertoast.showToast(
            msg: "pls enter email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }else if(password.isEmpty){
        Fluttertoast.showToast(
            msg: "pls enter password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }else if(password !=cpassword){
        Fluttertoast.showToast(
            msg: "pls verify password",
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
     Map<String,dynamic> row={
       Db_AdminHelper.Id : _myIdController.text,
       Db_AdminHelper.Name :_myNameController.text,
       Db_AdminHelper.Email :_myEmailController.text,
       Db_AdminHelper.Password:_myPwdController.text
     };
     try {
       final id = await dbaHelper.insertAdmin(row);
        if (id >0) {
          Fluttertoast.showToast(
              msg: "successfully saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
     }
     catch(error){
       print(error);
       Fluttertoast.showToast(
           msg: "error occured",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.blue,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }

  }
   @override
   void dispose(){
     _myIdController.dispose();
     _myNameController.dispose();
     _myEmailController.dispose();
     _myPwdController.dispose();
     _myCPwdController.dispose();
     super.dispose();
   }
}

