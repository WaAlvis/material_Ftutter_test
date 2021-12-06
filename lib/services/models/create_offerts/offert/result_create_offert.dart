import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/advertisement_pay_account.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';

part 'result_create_offert.g.dart';

@JsonSerializable()
class ResultCreateOffert {
  ResultCreateOffert(
      {
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
});

  factory ResultCreateOffert.fromJson(Map<String, dynamic> json) =>
      _$ResultCreateOffertFromJson(json);

  String id;
  String idTypeAdvertisement;
  String idCountry;
  String valueToSell;
  String margin;
  String termsOfTrade;
  String idUserPublish;
  String idStatus;
  String expiredDate;
  List<AdvertisementPayAccount> advertisementPayAccount;


  Map<String, dynamic> toJson() => _$ResultCreateOffertToJson(this);
}
