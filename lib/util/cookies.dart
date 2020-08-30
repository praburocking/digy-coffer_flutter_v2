import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CookieWrapper {
  String uri = "https://diggy-coffer.herokuapp.com";
  String token="token";
  String email="email";
  String username="username";
  PersistCookieJar cj;
  static Future<CookieWrapper> getInstance() async{
    CookieWrapper cw=new CookieWrapper();
    final tempDir = await getApplicationDocumentsDirectory();
    String tempPath =tempDir.path;
    cw.cj=new PersistCookieJar(dir:'$tempPath/cookies');
    return cw;
  }

  void setCookie(String name, String value) {
    List<Cookie> cookies = [new Cookie(name, value)];
    cj.saveFromResponse(Uri.parse(uri), cookies);
  }

  String getCookie(String name) {
    List<Cookie> results = cj.loadForRequest(Uri.parse(uri));
    String value=null;
    results.forEach((Cookie cookie) {
      if (name == cookie.name) {
        value= cookie.value;
      }
    });
    return value;
  }

  String getToken(){
   // print("token  "+getCookie(token));
   return getCookie(token);
  }

  void deleteCookie() {
   // cj.delete(Uri.parse(uri),[bool withDomainSharedCookie = false] );
   cj.deleteAll();


  }


  void setAuthorizationCookies(String authtoken,String userName,String email) {
//    if (userData["user"] && userData["authtoken"] && userData["user"]["username"] &&
//        userData["user"]["email"]) {
      setCookie(this.token,authtoken);
      setCookie(this.username,userName );
      setCookie(this.email,email);
//    }
//    else {
//      throw ("data not found");
//    }
  }

//  void deleteAuthorizationCookies() {
//    deleteCookie('token');
//    deleteCookie("username");
//    deleteCookie("email");
//
//  }

  setAuthorizationHeader() {
    var token = "Token " + getCookie("token");
    var header = {"headers": {"Authorization": token}};
    return header;
  }
}