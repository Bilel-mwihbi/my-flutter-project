import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';

import 'package:flutter_project/views/adminView/AddCatgory.dart';
import 'package:flutter_project/views/adminView/AddComponent.dart';
import 'package:flutter_project/views/adminView/EditComponent.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbaHelper = Db_AdminHelper.instance;

  late List<Map<String, dynamic>>  myComp;

  @override
  void initState(){
    super.initState();
    myComp=[];
    _getComponents();
  }

  void _getComponents() async{

    final dbaHelper = Db_AdminHelper.instance;
    final allRows = await dbaHelper.getAllCom();
    myComp=allRows;
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    print(myComp);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Home"),),
      body:ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: myComp.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key:  UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${myComp[index]["component_name"]}  ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  ${myComp[index]["category_name"]}  ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${myComp[index]["qte"]}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_)=>EditComponent(
                                  //  lists:myComp[index]
                                  )));
                            },
                            color:Colors.deepOrange,
                            child: Icon(Icons.edit,color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            onDismissed: (direction) {
              dbaHelper.deleteComponent(myComp[index]["component_id"]);
            },
          );
        },
      ),
    );
  }
}


class  MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black54,
                        Colors.blueAccent,
                      ]
                    )
            ),
              child:Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/login.png"),
              radius: 50,
            ),
          )
          ),
          ListTile(
            title: Text("Home",style: TextStyle(fontSize: 20),),
            leading: Icon(Icons.home,color: Colors.blueAccent,),
            trailing: Icon(Icons.arrow_right,color: Colors.grey,),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_)=>MainView()));
            },
          ),
          ListTile(
            title: Text("Add new Category",style: TextStyle(fontSize: 20),),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_)=>AddCategory()));
            },
            leading: Icon(Icons.add_box_outlined,color: Colors.blueAccent,),
            trailing: Icon(Icons.arrow_right,color: Colors.grey,),
          ),
          ListTile(
            title: Text("Add new Component",style: TextStyle(fontSize: 20),),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_)=>AddComponent()));
            },
            leading: Icon(Icons.add_business,color: Colors.blueAccent,),
            trailing: Icon(Icons.arrow_right,color: Colors.grey,),
          ),
          ListTile(
            title: Text("Sign off",style: TextStyle(fontSize: 20),),
            leading: Icon(Icons.logout,color: Colors.blueAccent,),
            trailing: Icon(Icons.arrow_right,color: Colors.grey,),
          )
        ],
      ),
    );
  }

}

