import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_documents.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_pay_account.dart';

part 'advertisement.g.dart';

@JsonSerializable()
class Advertisement {
  Advertisement({
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
    required this.advertisementPayAccount,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementFromJson(json);

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
  List<AdvertisementPayAccount> advertisementPayAccount;
  List<AdvertisementDocuments>? advertisementDocuments;

  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
