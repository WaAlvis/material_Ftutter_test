import 'package:flutter/material.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/detail_offer/body_add_pay_account.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';

class DataUserProvider with ChangeNotifier {
  // late TokenLogin _tokenLogin;
  // TokenLogin get getTokenLogin => _tokenLogin;
  // void setTokenLogin(TokenLogin tokenLogin) {
  //   _tokenLogin = tokenLogin;
  //   notifyListeners();
  // }

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

  // --- Objetos para almacenar datos temporalmente, se usan con DailyConnect ---

  BodyOffer? _bodyOffer;
  BodyOffer? get getBodyOffer => _bodyOffer;
  void setBodyOffer(BodyOffer? bodyOffer) {
    _bodyOffer = bodyOffer;
    notifyListeners();
  }

  BodyAddPayAccount? _bodyAddPayAccount;
  BodyAddPayAccount? get getBodyAddPayAccount => _bodyAddPayAccount;
  void setBodyAddPayAccount(BodyAddPayAccount? bodyAddPayAccount) {
    _bodyAddPayAccount = bodyAddPayAccount;
    notifyListeners();
  }

  BodyUpdateStatus? _bodyUpdateStatus;
  BodyUpdateStatus? get getBodyUpdateStatus => _bodyUpdateStatus;
  void setBodyUpdateStatus(BodyUpdateStatus? bodyUpdateStatus) {
    _bodyUpdateStatus = bodyUpdateStatus;
    notifyListeners();
  }

  void logoutClear() {
    _dataUser = null;
    _address = null;
    _midailyConnectCode = null;
    _bodyOffer = null;
    _bodyAddPayAccount = null;
    _bodyUpdateStatus = null;
    notifyListeners();
  }

  // --- Objetos para almacenar configuraciones ---

}
