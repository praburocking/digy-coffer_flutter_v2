import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:digy_coffer/pages/account.dart';
import 'package:digy_coffer/utilWidgets/alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'dart:io';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  final List<String> entries = <String>['A', 'B', 'C','D','E','F','G','H','I','J','K','L'];
 // final List<int> colorCodes = <int>[600, 500, 400];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //final GlobalKey<CircularPercentIndicatorState>  _circularePercent=new GlobalKey<CircularPercentIndicatorState>();
  String _fileString = '';
  Set<String> lastFiles;
  int _currentActiveList;
  double _listElementHeight=50;
  String type;
  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double listViewHeight=height*0.60;


    return  Scaffold(
      key:_scaffoldKey,
      backgroundColor:Color(0xff030931),
      endDrawer: Drawer(
            child:    account()
      ),
      appBar: AppBar(
        title: Text("Digy-Coffer",style: TextStyle(letterSpacing: 3),),
        centerTitle: true,
        backgroundColor: Color(0xff030931),
        elevation: 0,
        leading: Image.asset('images/logo_blue1.png',height: 100,fit: BoxFit.contain,cacheHeight: 150,),

        actions: [
      IconButton(
      icon: Icon(
      Icons.account_circle,
        color: Colors.white,
        size: 25,
      ),
      onPressed: () {
        // do something
        _scaffoldKey.currentState.openEndDrawer();
      },
    )
        ]
        ,
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          color:  Color(0xff030931),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {

                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: new CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "70.0%",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                    ),
                    footer: new Text(
                      "Storage  Space",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0,color: Colors.white),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purple,

                  ),
                ),
              ),
              Divider(height: 50,color: Colors.grey,),

              Container(
                height:listViewHeight,
                child: ListView.separated(

                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      height: index==_currentActiveList?_listElementHeight:50,
                      color: Colors.blue[100+(index*100)],//Color(0xff1990ff)
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                 child: Text('Entry ${entries[index]}',style: TextStyle(color: Colors.white),)
                              ),
                              Container(
                                child:Row(
                                  children:
                                  [
                                    IconButton(icon:(_currentActiveList==index && type=="delete")?Icon(Icons.close,color: Colors.red,): Icon(Icons.delete,color: Colors.white,),onPressed: (){
                                      print("pressed");

                                      setState(() {
                                        if(_currentActiveList==index && type=="delete"){
                                          _currentActiveList=null;
                                        }else {
                                          _currentActiveList = index;
                                          _listElementHeight = 230;
                                          type="delete";
                                        }
                                      });
                                      print(_currentActiveList);

                                    },),
                                    Container(child: VerticalDivider(color: Colors.black, width: 20,),margin: EdgeInsets.only(top: 15,bottom: 15),),
                                    IconButton(icon:(_currentActiveList==index && type=="download")?Icon(Icons.close,color: Colors.red,): Icon(Icons.file_download,color: Colors.white,),onPressed: (){
                                      print("pressed");

                                      setState(() {
                                        if(_currentActiveList==index && type=="download"){
                                          _currentActiveList=null;
                                        }else {
                                          _currentActiveList = index;
                                          _listElementHeight = 260;
                                          type="download";
                                        }
                                      });
                                      print(_currentActiveList);

                                    },),

                                  ],
                                )
                              )
                            ],
                          ),

                        if( _currentActiveList==index)
                          Expanded(child: Alert(type: type))
                        ],

                      )//Center(child: Text('Entry ${entries[index]}')),
                    );
                  },
                 separatorBuilder: (BuildContext context, int index) => const Divider(height: 2,),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         var filePath = await FilePicker.getFilePath(type: FileType.any);
        },
        child: Icon(Icons.cloud_upload),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }


}
