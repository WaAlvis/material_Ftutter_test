import 'package:flutter/material.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';

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

  String? _address;
  String? get getAddress => _address;
  void setAddress(String? address) {
    _address = address;
    notifyListeners();
  }

  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

}
