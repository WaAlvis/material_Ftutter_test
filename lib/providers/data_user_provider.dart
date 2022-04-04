import 'package:flutter/material.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
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

  String? _address;
  String? get getAddress => _address;
  void setAddress(String? address) {
    _address = address;
    notifyListeners();
  }

  BodyOffer? _bodyOffer;
  BodyOffer? get getBodyOffer => _bodyOffer;
  void setBodyOffer(BodyOffer? bodyOffer) {
    _bodyOffer = bodyOffer;
    notifyListeners();
  }

  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

}
