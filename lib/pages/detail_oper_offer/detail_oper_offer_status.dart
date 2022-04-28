import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/detail_oper_offer/advertisement_document.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/view_model.dart';

class DetailOperOfferStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final ResultDataAdvertisement? item;
  final int dateOfExpire;
  final bool isBuy;
  final String? state;
  final bool isOper2;
  final String? extensionFile;
  final String? userId;
  List<AccountType> listAccountTypes;
  List<Bank> banks;
  List<AdvertisementDocument> listAdvertisementDoc;
  List<DocType>? docsType;
  String? rateUser;

  // agregar demas estados con el servicio

  DetailOperOfferStatus(
      {required this.isLoading,
      required this.isError,
      required this.item,
      required this.isBuy,
      required this.docsType,
      required this.dateOfExpire,
      required this.listAdvertisementDoc,
      required this.banks,
      required this.state,
      required this.listAccountTypes,
      required this.isOper2,
      required this.extensionFile,
      required this.userId,
      required this.rateUser});

  DetailOperOfferStatus copyWith({
    int? dateOfExpire,
    bool? isLoading,
    bool? isError,
    bool? isBuy,
    bool? isOper2,
    List<DocType>? docsType,
    ResultDataAdvertisement? item,
    List<AdvertisementDocument>? listAdvertisementDoc,
    List<Bank>? banks,
    String? state,
    List<AccountType>? resultAccountTypes,
    String? extensionFile,
    String? userId,
    String? rateUser,
  }) {
    return DetailOperOfferStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isBuy: isBuy ?? this.isBuy,
      item: item ?? this.item,
      dateOfExpire: dateOfExpire ?? this.dateOfExpire,
      listAdvertisementDoc: listAdvertisementDoc ?? this.listAdvertisementDoc,
      banks: banks ?? this.banks,
      docsType: docsType ?? this.docsType,
      state: state ?? this.state,
      listAccountTypes: listAccountTypes,
      isOper2: isOper2 ?? this.isOper2,
      extensionFile: extensionFile ?? extensionFile,
      userId: userId ?? this.userId,
      rateUser: rateUser ?? rateUser,
    );
  }
}
