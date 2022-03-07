import 'package:flutter/material.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/user_login.dart';

class DataUserProvider with ChangeNotifier  {

  ResultDataUser? _DataUser;
  ResultDataUser? get getDataUserLogged => _DataUser;
  void setDataUserLogged(ResultDataUser? user) {
    _DataUser = user;
    notifyListeners();
  }

  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

}
