import 'package:json_annotation/json_annotation.dart';

part 'advertisement.g.dart';

@JsonSerializable()
class Advertisement {
  Advertisement({
    required this.id,
    required this.idTypeAdvertisement,
    required this.idCountry,
    required this.idTypePay,
    required this.idMoney,
    required this.idTypeReference,
    required this.bankName,
    required this.valueToSell,
    required this.margin,
    required this.minTransactionLimit,
    required this.maxTransactionLimit,
    required this.termsOfTrade,
    required this.paymentWindow,
    required this.trackLiquidity,
    required this.displayReference,
    required this.idUserPublish,
    required this.idStatus,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementFromJson(json);

  String id;
  String idTypeAdvertisement;
  String idCountry;
  String idTypePay;
  String idMoney;
  String idTypeReference;
  String bankName;
  String valueToSell;
  String margin;
  String minTransactionLimit;
  String maxTransactionLimit;
  String termsOfTrade;
  String paymentWindow;
  bool trackLiquidity;
  bool displayReference;
  String idUserPublish;
  String idStatus;

  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
