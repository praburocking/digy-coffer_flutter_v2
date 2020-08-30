import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animations/loading_animations.dart';


class SplashScreen extends StatelessWidget {

  Future<bool> getInitalPage(BuildContext context)async {
    if(await context.watch<UserNotifier>().isLoggedIn(false)){
      Navigator.pushNamed(context, '/home');
      return true;
    }else{
      Navigator.pushNamed(context, '/signInSignUp');
      //Navigator.pushNamed(context, '/home');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    getInitalPage(context);
    return Scaffold(
      backgroundColor: Color(0xff030931),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Title(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'DIGY-COFFER',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color(0xff1990ff),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  Text(
                    'A  Safest place to store your digital documents',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ),
Container(
  child:LoadingBouncingGrid.square(
  size: 100,
    borderSize: 1,
    backgroundColor:Color(0xff1990ff) ,
  )
),
//          Container(
//            child: GFLoader(
//                type:GFLoaderType.square
//            ),
//          ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("Loading..",style: TextStyle(color: Colors.white,fontSize: 20),),
            )

          ],
        ),
      ),
    );
  }
}