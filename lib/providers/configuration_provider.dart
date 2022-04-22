import 'package:flutter/material.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';

class ConfigurationProvider with ChangeNotifier {
  ResultGetBanks? _resultBanks;
  ResultGetBanks? get getResultBanks => _resultBanks;
  void setResultBanks(ResultGetBanks? resultBanks) {
    _resultBanks = resultBanks;
    notifyListeners();
  }

  ResultGetDocsType? _resultDocsTypes;
  ResultGetDocsType? get getResultDocsTypes => _resultDocsTypes;
  void setResultDocsTypes(ResultGetDocsType? resultDocsTypes) {
    _resultDocsTypes = resultDocsTypes;
    notifyListeners();
  }

  List<AccountType>? _resultAccountTypes;
  List<AccountType>? get getResultAccountTypes => _resultAccountTypes;
  void setResultAccountTypes(List<AccountType>? resultAccountTypes) {
    _resultAccountTypes = resultAccountTypes;
    notifyListeners();
  }

  ResultTypeOffer? _resultTypeOffer;
  ResultTypeOffer? get getResultTypeOffer => _resultTypeOffer;
  void setResultTypeOffer(ResultTypeOffer? resultTypeOffer) {
    _resultTypeOffer = resultTypeOffer;
    notifyListeners();
  }
}
