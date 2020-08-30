import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digy_coffer/connectToServer.dart' as CTS;
import 'package:http/http.dart' as http;
import 'package:digy_coffer/utilWidgets/email.dart';
import 'package:digy_coffer/utilWidgets/password.dart';
import 'dart:io';
import 'package:digy_coffer/util/cookies.dart';
import 'package:provider/provider.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';




class signIn extends StatefulWidget {
  double loginYOffset;
  Color frontColor;
  final Function(int) changePageState;
  final Function(bool) changeIsLoading;
  signIn({@required this.loginYOffset,@required this.frontColor,@required this.changePageState,@required this.changeIsLoading});
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  double width;
  double hight;
  String errorMessage;
  final Email email=Email();
  final Password password=Password();
  final _formKey = GlobalKey<FormState>();
  void pushDataToSign(BuildContext context) async {
    widget.changeIsLoading(true);
    print("push data toSignin");
    bool isLoginSuccess=await context.read<UserNotifier>().loginIn(false,email.emailController.text, password.passwordController.text);
    widget.changeIsLoading(false);

    if(isLoginSuccess){Navigator.pushNamed(context, '/home');}
    setState(() {
      if(!isLoginSuccess){
        errorMessage="invalid credentials";
      }else {
        widget.changePageState(0);
        email.emailController.text = "";
        password.passwordController.text = "";
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    hight = MediaQuery.of(context).size.height;
    TextEditingController emailController = TextEditingController();

    return  AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 2000),
      transform: Matrix4.translationValues(0,widget.loginYOffset, 1),

      decoration: BoxDecoration(
        color: widget.frontColor, //Color(0xffff3c55),

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SizedBox(
          height: hight-(hight*0.30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Title(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff1990ff),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(

                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: email,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15,bottom: 15),
                      child: password,
                    ),
                  ],
                ),
              ),

              Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                    child: GestureDetector(
                      onTap: () {
                        if(_formKey.currentState.validate()) {
                          pushDataToSign(context);

                        }
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
                                "Sign In",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: GestureDetector(
                      onTap: () {

                        widget.changePageState(2);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border:Border.all( color: const Color(0xff1990ff)),
                            //color: Color(0xff1990ff),
                            borderRadius: BorderRadius.circular(11)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create New Account",
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
                ],
              ),

            ],
          ),
        ),),

    );
  }
}
