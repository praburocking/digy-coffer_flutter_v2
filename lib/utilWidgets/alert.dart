import 'package:digy_coffer/utilWidgets/email.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
class Alert extends StatefulWidget {

  final type;
  Alert({this.type});
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
      height: widget.type=="download"?200:150,
      child: GFAlert(
        title:widget.type=="delete"?'Delete !':"Download !",
        titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:18 ),
        backgroundColor: Color(0xff030931),
        contentTextStyle: TextStyle(color: Colors.white),
        content:widget.type=="delete"? 'Are you sure want to delete this file?':"Kindly enter the password to download the file.",
        type: GFAlertType.rounded,
        bottombar: Container(

          child: Column(
            children: [
             if( widget.type=="download")
               Container(
                 padding: EdgeInsets.only(top: 5,bottom: 5),
                child: EncryptionField(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: <Widget>[
                  Container(
                    child: Material(
                      borderRadius:BorderRadius.circular(11) ,
                  color: Colors.red,
                      child: InkWell(

                        onTap: () {


                          // Navigator.pushNamed(context, '/home');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.type=="delete"?Icons.delete:Icons.file_download,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${widget.type}",
                                  style:
                                  TextStyle(color: Colors.white, fontSize:15 ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
          ),
    );
  }
}


class EncryptionField extends StatefulWidget {
  @override
  _EncryptionFieldState createState() => _EncryptionFieldState();
  final passwordController = TextEditingController();
}


class _EncryptionFieldState extends State<EncryptionField> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);
    return Container(child:
    TextFormField(
      obscureText: true,
      style: style,
      controller: widget.passwordController,
      validator: (value){
        if(value.isEmpty){
          return "Please enter the encryption key";
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        prefixIcon: Icon(
          Icons.security,
          color: Colors.white,
        ),
        labelText: 'Encrption Key',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    ),);
  }
}