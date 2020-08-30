import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';
import 'package:digy_coffer/utilWidgets/signin.dart';
import 'package:digy_coffer/utilWidgets/signup.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:getwidget/getwidget.dart';

class signInSignUp extends StatefulWidget {
  @override
  _signInSignUpState createState() => _signInSignUpState();


}

class _signInSignUpState extends State<signInSignUp> {
  @override
  Color _bgColor = Color(0xff030931); //Color(0xffff3c55);
  Color _textColor = Colors.white;
  Color _frontColor = Colors.blue;
  Color _titleColor = Color(0xff1990ff);
  double titleSize=37;
  double subTitleSize=18;
  double width = null;
  double hight = null;
  double loginYOffset = 0;
  double signupYOffset = 0;
  int _pageState = 0;
  bool _isLoading=false;
  String _exceptionText;
  void changePageState(int state) {
    setState(() {
      _pageState = state;
    });
  }
  void changeIsLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }
  void changeExceptionText(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  Future<bool> getInitalPage(BuildContext context)async {

    if(await  context.watch<UserNotifier>().isLoggedIn(false)){
      Navigator.pushNamed(context, '/home');
      return true;
    }
  }



  Widget build(BuildContext context) {
   // getInitalPage(context);
    width = MediaQuery.of(context).size.width;
    hight = MediaQuery.of(context).size.height;
    switch (_pageState) {
      //home page
      case 0:
        _bgColor = Color(0xff030931);
        _frontColor = Colors.white;
        signupYOffset = hight;
        loginYOffset = hight;
        _textColor = Colors.white;
        titleSize=37;
        subTitleSize=18;
        break;
      //signin page
      case 1:
        _bgColor = Colors.white;
        _frontColor =
            Color(0xff030931); // Color(0xffff3c55);//Color(0xff030931);
        signupYOffset = hight;
        loginYOffset = hight * 0.30;
        _textColor = Colors.black;
        titleSize=35;
        subTitleSize=16;
        break;

      //signup page
      case 2:
        _bgColor = Colors.white;
        _textColor = Colors.black;
        _frontColor =
            Color(0xff030931); // Color(0xffff3c55);//Color(0xff030931);
        signupYOffset = hight * 0.28;
        loginYOffset = hight;
        titleSize=33;
        subTitleSize=15;
        break;
    }

    return Scaffold(
      backgroundColor: _bgColor,
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.blue,
        progressIndicator: LoadingBouncingGrid.square(
          size: 100,
          borderColor:Color(0xff1990ff) ,
          borderSize: 1,
            backgroundColor:Color(0xff1990ff) ,

        ),
        child: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 4000),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 0;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Center(
                        child: Column(
                          children: [
                            Title(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'DIGY-COFFER',
                                  style: TextStyle(
                                      fontSize: titleSize,
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
                                color: _textColor,
                                fontFamily: 'Montserrat',
                                fontSize: subTitleSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Image.asset(
                        "images/logo_blue1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        changePageState(1);

                       // Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color(0xff1990ff),
                            borderRadius: BorderRadius.circular(11)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Started",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GFToast(
                    text:_exceptionText,

//                    button: GFButton(
//                      onPressed: () {},
//                      text: 'Close',
//                      type: GFButtonType.transparent,
//                      color: Colors.red,
//                    ),
                    autoDismiss: true,
                  ),

                ],
              ),
            ),
           signIn(loginYOffset: loginYOffset,frontColor: _frontColor,changePageState: changePageState,changeIsLoading: changeIsLoading,),
            signUp(signupYOffset: signupYOffset,frontColor: _frontColor,changePageState: changePageState,changeIsLoading: changeIsLoading,),
          ],
        ),
      ),
    );
  }
}


