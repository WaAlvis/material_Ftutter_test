import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/detail_oper_offer/advertisement_document.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_pay_account.dart';

part 'result_get_advertisement.g.dart';

@JsonSerializable()
class ResultDataAdvertisement {
  ResultDataAdvertisement({
    required this.id,
    required this.reference,
    required this.idTypeAdvertisement,
    required this.idCountry,
    required this.valueToSell,
    required this.margin,
    required this.termsOfTrade,
    required this.idUserPublish,
    required this.idStatus,
    required this.expiredDate,
    required this.hoursLimitPay,
    required this.modificationDate,
    required this.creationDate,
    this.advertisementPayAccount,
    this.advertisementDocuments,
  });
  factory ResultDataAdvertisement.fromJson(Map<String, dynamic> json) =>
      _$ResultDataAdvertisementFromJson(json);
  String id;
  int reference;
  String idTypeAdvertisement;
  String idCountry;
  String valueToSell;
  String margin;
  String termsOfTrade;
  String idUserPublish;
  String idStatus;
  int expiredDate;
  int hoursLimitPay;
  int modificationDate;
  int creationDate;
  List<AdvertisementPayAccount>? advertisementPayAccount;
  List<AdvertisementDocument>? advertisementDocuments;

  Map<String, dynamic> toJson() => _$ResultDataAdvertisementToJson(this);
}
