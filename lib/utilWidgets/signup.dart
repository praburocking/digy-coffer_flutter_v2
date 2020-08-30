import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digy_coffer/connectToServer.dart' as CTS;
import 'package:http/http.dart' as http;
import 'package:digy_coffer/utilWidgets/email.dart';
import 'package:digy_coffer/utilWidgets/password.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';
import 'package:provider/provider.dart';

class signUp extends StatefulWidget {
  @override
  double signupYOffset;
  Color frontColor;
  final Function(int) changePageState;
  final Function(bool) changeIsLoading;
  signUp({@required  this.signupYOffset,@required this.frontColor,@required  this.changePageState, @required this.changeIsLoading});
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  double width;
  double hight;
  Email email=Email();
  Password password=Password();
  String errorMessage;
  final _formKey = GlobalKey<FormState>();

  void pushDataToSign(BuildContext context) async {
    widget.changeIsLoading(true);
    print("push data toSignin");
    bool isSignupSuccess=await context.read<UserNotifier>().signUp(false,email.emailController.text, password.passwordController.text);
    widget.changeIsLoading(false);

    if(isSignupSuccess){Navigator.pushNamed(context, '/home');}
    setState(() {
      if(!isSignupSuccess){
        errorMessage="invalid credentials";
      }else {
        widget.changePageState(0);
        email.emailController.text = "";
        password.passwordController.text = "";
      }
    });

  }


  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    hight = MediaQuery.of(context).size.height;
    TextEditingController emailController = TextEditingController();



    return  AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 2000),
      transform: Matrix4.translationValues(0,widget.signupYOffset, 1),

      decoration: BoxDecoration(
        color: widget.frontColor, //Color(0xffff3c55),

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SizedBox(
          height: hight-(hight*0.27),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Title(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    'Sign Up',
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
                                "Sign Up",
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

                        widget.changePageState(1);
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
                                "Already Have a Account, Login",
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


