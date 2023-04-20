import 'dart:convert';

class LoginModel {  
  String user;  
  String pass;  
  bool firstLogin;

  @override
  String toString() {
    return json.encode({
      'user': this.user,
      'pass': this.pass,
      'login': this.firstLogin
    });
  }

  static LoginModel fromJson(djson){
    LoginModel lm = LoginModel();
    lm.user       = djson['user'];
    lm.pass       = djson['password'];
    lm.firstLogin = djson['login'];
    return lm;
  }
}