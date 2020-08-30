import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Email extends StatefulWidget {

  @override
  _EmailState createState() => _EmailState();
  TextEditingController emailController=TextEditingController();
  TextFormField emailField=TextFormField();


}

class _EmailState extends State<Email> {

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.emailController.dispose();
    super.dispose();
  }


  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  @override
  void init(){
    setState(() {
      widget.emailController.text="asdfasd@adsfasd.com";
    });

  }

  @override
  Widget build(BuildContext context) {

    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);
    widget.emailField=TextFormField(
      obscureText: false,
      style: style,
      controller: widget.emailController,

      validator: (value) {
       if(!EmailValidator.validate(value)){
          return 'Please enter proper email address';
        }else {
         return null;
       }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ) ,
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),),
    );
    return Container(child:widget.emailField ,);
  }
}