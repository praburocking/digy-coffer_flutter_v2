import 'package:flutter/foundation.dart';
import 'package:digy_coffer/util/cookies.dart';
import 'package:digy_coffer/connectToServer.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {

ConnectToServer cts= ConnectToServer();
String token;
String email;
String userName;
String _stripeCustomerId;
String _licenseType;
double _totalSpace;
double _usedSpace;
String _errorMessage;

String getStripeCustomerId(){
  return _stripeCustomerId;
}
String getLicenseType(){
  return _licenseType;
}
double getTotalSpace(){
  return _totalSpace;
}
double getUsedSpace(){
  return _usedSpace;
}


String getToken(){
  return token;
}
void setToken(String token){
   this.token=token;
}
String getEmail(){
  return email;
}
void setEmail(String email){
  this.email=email;
}
String  getUserName(){
  return userName;
}

void setUserName(String userName){
  this.userName=userName;
}

String getErrorMessage(){
  return _errorMessage;
}


  /// Internal, private state of the cart.


  /// The current total price of all items (assuming all items cost $42).


  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.

  Future<bool> loginIn(bool isNotify,String email,String password) async {
    CookieWrapper _cookieWrapper = await CookieWrapper.getInstance();
   Response response =await cts.signin(email,password);
   print(response.body);
    if (!cts.errorCode.contains(response.statusCode)) {
      var data=convert.jsonDecode(response.body);
       this.token=data["authtoken"];
       this.userName=data["user"]["username"];
       this._licenseType=data["license"]["licenseType"];
      this._totalSpace=data["license"]["totalSpace"];
      this._usedSpace=data["license"]["usedSpace"];
      this._stripeCustomerId=data["license"]["stripe_customer_id"];
       this.email=data["user"]["email"];
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("email", this.email);
      _cookieWrapper.setAuthorizationCookies(this.token,this.userName,this.email);
      return true;
    }
    else{
      _errorMessage=response.body;
    }
    if(isNotify) {
      notifyListeners();
    }
    return false;
    // This call tells the widgets that are listening to this model to rebuild.
  }



Future<bool> signUp(bool isNotify,String email,String password) async{
    CookieWrapper _cookieWrapper = await CookieWrapper.getInstance();
    Response response =await cts.signup(email,password);
    print(response.body);
    if (!cts.errorCode.contains(response.statusCode)) {
      var data=convert.jsonDecode(response.body);
      this.token=data["authtoken"];
      this.userName=data["user"]["username"];
      this.email=data["user"]["email"];
      this._licenseType=data["license"]["licenseType"];
      this._totalSpace=data["license"]["totalSpace"];
      this._usedSpace=data["license"]["usedSpace"];
      this._stripeCustomerId=data["license"]["stripe_customer_id"];
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("email", this.email);
      _cookieWrapper.setAuthorizationCookies(this.token,this.userName,this.email);
      return true;
    }
    else{
      _errorMessage=response.body;
    }
    if(isNotify) {
      notifyListeners();
    }
    return false;
  }

  Future<bool> isLoggedIn(bool isNotify)async {
    CookieWrapper _cookieWrapper = await CookieWrapper.getInstance();
    if (_cookieWrapper.getToken() != null) {
      Response response = await cts.getAccount();
      print("loggin check");
      print(response.body);
      if (!cts.errorCode.contains(response.statusCode)) {
        var data=convert.jsonDecode(response.body);
        this.userName=data["user"]["username"];
        this.email=data["user"]["email"];
        this._licenseType=data["license"]["licenseType"];
        this._totalSpace=data["license"]["totalSpace"];
        this._usedSpace=data["license"]["usedSpace"];
        this._stripeCustomerId=data["license"]["stripe_customer_id"];
        this.token=_cookieWrapper.getToken();
        print(data);
        //_cookieWrapper.setAuthorizationCookies();
        return true;;
      }
      else{
        _cookieWrapper.deleteCookie();
      }
    }
    if(isNotify) {
      notifyListeners();
    }
    return false;
  }

Future<bool> logOut(bool isNotify)async {
  CookieWrapper _cookieWrapper = await CookieWrapper.getInstance();
  if (_cookieWrapper.getToken() != null) {
    Response response = await cts.logOut();
    print("logout check");
    print(response.body);
    if (!cts.errorCode.contains(response.statusCode)) {
      print(response.body);
      _cookieWrapper.deleteCookie();
      //_cookieWrapper.setAuthorizationCookies();
      return true;;
    }
  }
  if(isNotify) {
    notifyListeners();
  }
  return false;
}
  /// Removes all items from the cart.
  void removeAll() {

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}