import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:digy_coffer/util/cookies.dart';

class ConnectToServer {
String  baseUrl="https://diggy-coffer.herokuapp.com/api/v1/";
Future<CookieWrapper> cookie= CookieWrapper.getInstance();
List errorCode=[400,401,404,500];

 Future<http.Response> signin(String email,String password) async {
 Map body={"email":email,"password":password};
 var jsonBody=convert.jsonEncode(body);
 print("body map==>"+jsonBody);
 Map<String,String> headers=Map<String,String>();
 headers={'content-type':'application/json'};
 var response = await http.post(baseUrl+"iam/login",headers: headers,body: jsonBody);
 return response;
}

Future<http.Response> signup(String email,String password) async {
 Map body={"email":email,"password":password,"username":email.split("@")[0]};
 var jsonBody=convert.jsonEncode(body);
 print("body map==>"+jsonBody);
 Map<String,String> headers=Map<String,String>();
 headers={'content-type':'application/json'};
 var response = await http.post(baseUrl+"iam/signup",headers: headers,body: jsonBody);
 return response;
}

Future<http.Response> getAccount() async {
 Map<String,String> headers=Map<String,String>();
 headers={'content-type':'application/json','Authorization': "Token "+await cookie.then((value) => value.getToken())};
 print(headers);
 var response = await http.get(baseUrl+"iam/accounts",headers: headers,);
 return response;
}

Future<http.Response> logOut() async {
 Map<String,String> headers=Map<String,String>();
 headers={'content-type':'application/json','Authorization': "Token "+await cookie.then((value) => value.getToken())};
 print(headers);
 var response = await http.post(baseUrl+"iam/logout",headers: headers,body: "{ signout: true }");
 return response;
}

}


