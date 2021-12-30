import 'package:flutter/material.dart';
import 'package:flutter_project/DataBase/Db_AdminHelper.dart';

import 'MainView.dart';

class SearchContents extends StatefulWidget {
  const SearchContents({Key? key}) : super(key: key);

  @override
  _SearchContentsState createState() => _SearchContentsState();
}


class _SearchContentsState extends State<SearchContents> {

  final dbaHelper = Db_AdminHelper.instance;

  late List<Map<String, dynamic>>  myComp=[];
  late String keyword;
  @override
  void initState(){
    super.initState();

    _getComponents();
  }

  void _getComponents() async{

    final dbaHelper = Db_AdminHelper.instance;
    final allRows = await dbaHelper.searchComponents(keyword);
    myComp=allRows!;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    print("****");
    print(myComp);
    return Scaffold(
      appBar: AppBar(
        title: Text("search component "),
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
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Key word'),
                  onChanged: (value){
                    keyword=value;
                    print(keyword);
                    setState(() {
                      _getComponents();
                    });
                  },
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: myComp.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Reference : ${myComp[index]["component_name"]} '),
                    subtitle: Text('Quantity : ${myComp[index]["qte"]}'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
