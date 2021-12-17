import 'package:flutter/material.dart';
import 'package:localdaily/services/models/login/user_login.dart';

class UserProvider with ChangeNotifier {

  UserLogin? _user;
  UserLogin? get getUserLogged => _user;
  void setUserLogged(UserLogin? user) {
    _user = user;
    notifyListeners();
  }

  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

}
