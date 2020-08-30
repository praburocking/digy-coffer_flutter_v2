import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';

import 'package:getwidget/getwidget.dart';


class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();

}

class _accountState extends State<account> {
  int counter=0;
  final List<String> entries = <String>['A', 'B', 'C','D',];
  final Map<int,String> noVsLabel={0:"userName",1:"email",2:"license Type",3:"total Space",4:"usedSpace",5:"password"};

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier=context.watch<UserNotifier>();
    final Map<int,String> noVsValue={0:"${userNotifier.getUserName()}",1:"${userNotifier.getEmail()}",2:"${userNotifier.getLicenseType()}",3:"${userNotifier.getTotalSpace()} MB",4:"${userNotifier.getUsedSpace()} MB",5:"password"};
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Account Information"),
//        backgroundColor: Colors.black,
//        centerTitle: true,
//      ),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height:0.25*height ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 40, child: Image.asset("images/userthumbnail.png")),
                        InputChip(
                            backgroundColor: Colors.blueGrey,
                            avatar: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.edit,color: Colors.black,),
                            ),
                            label: Text('Edit',style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              setState(() {
                                counter=counter+1;
                              });
                            }
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 50,color: Colors.grey,thickness: 2,),
                  Expanded(

                    child: new LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                      return  Container(
                       height: constraints.maxHeight,
                          child: ListView.builder(

                            padding: const EdgeInsets.all(8),
                            itemCount: noVsLabel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(

                                  child: Text("${noVsLabel[index]}",style: TextStyle(fontSize: 14,color: Colors.white),),
                                  ),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border:Border.all( color: Colors.purple[100 + (index * 100)],width: 0),
                                        borderRadius: BorderRadius.circular(11),

                                    ),
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(bottom: 10),


                                    child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                  child: Text('${noVsValue[index]} ',
                                                    style: TextStyle(
                                                        color: Colors.white,fontWeight: FontWeight.bold),)
                                              ),
                                              Container(
                                                  child: Row(
                                                    children:
                                                    [

                                                      Icon(Icons.edit,
                                                        color: Colors.white,),

                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ]), //Center(child: Text('Entry ${entries[index]}')),
                                  ),
                                ],
                              );
                            },
                            //separatorBuilder: (BuildContext context,
                               // int index) => const Divider(height: 2,),
                          ),
                        );}
                    ),
                  ),


                ],
              ),
            ),
//  Divider(color: Colors.red, ),
            Material(

              color: Color(0xfffc1414),
              child: InkWell(
                onTap: (){
                  Future<bool>  isLoggedOut=context.read<UserNotifier>().logOut(false);
                  isLoggedOut.then((value) => {if(value){Navigator.pushNamed(context, "/")}});
                 // Navigator.pushNamed(context, "/");
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign Out',style:TextStyle(color: Colors.white,)),
                      Icon(Icons.chevron_right,color: Colors.white,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black38,
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() {
//            counter=counter+1;
//          });
//        },
//        child: Icon(Icons.lock_outline),
//        backgroundColor: Colors.purple,
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

  }
}

