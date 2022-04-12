import 'package:flutter/material.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';

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

  ResultGetDocsType? _resultAccountTypes;
  ResultGetDocsType? get getResultAccountTypes => _resultAccountTypes;
  void setResultAccountTypes(ResultGetDocsType? resultAccountTypes) {
    _resultAccountTypes = resultAccountTypes;
    notifyListeners();
  }
}
