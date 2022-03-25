import 'package:flutter/material.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/user_login.dart';

class DataUserProvider with ChangeNotifier {
  ResultDataUser? _dataUser;
  ResultDataUser? get getDataUserLogged => _dataUser;
  void setDataUserLogged(ResultDataUser? user) {
    _dataUser = user;
    notifyListeners();
  }

  String? _midailyConnectCode;
  String? get getMiDailyConnectCode => _midailyConnectCode;
  void setMiDailyConnectCode(String? code) {
    _midailyConnectCode = code;
    notifyListeners();
  }

  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

}
