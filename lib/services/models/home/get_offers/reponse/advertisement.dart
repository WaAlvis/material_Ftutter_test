import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_pay_account.dart';

part 'advertisement.g.dart';

@JsonSerializable()
class Advertisement {
  Advertisement({
    required this.id,
    required this.idTypeAdvertisement,
    required this.idCountry,
    required this.valueToSell,
    required this.margin,
    required this.termsOfTrade,
    required this.idUserPublish,
    required this.idStatus,
    required this.expiredDate,
    required this.advertisementPayAccount,

    // required this.idTypePay,
    // required this.idMoney,
    // required this.idTypeReference,
    // required this.bankName,
    // required this.minTransactionLimit,
    // required this.maxTransactionLimit,
    // required this.paymentWindow,
    // required this.trackLiquidity,
    // required this.displayReference,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementFromJson(json);

  String id;
  String idTypeAdvertisement;
  String idCountry;
  String valueToSell;
  String margin;
  String termsOfTrade;
  String idUserPublish;
  String idStatus;
  int expiredDate;
  List<AdvertisementPayAccount> advertisementPayAccount;

  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
