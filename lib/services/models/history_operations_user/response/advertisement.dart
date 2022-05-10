import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/history_operations_user/response/advertisement_user_interaction.dart';
import 'package:localdaily/services/models/pagination.dart';

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
    required this.modificationDate,
    required this.creationDate,
    required this.advertisementPayAccount,
    required this.advertisementDocuments,
    required this. advertisementUserInteraction,
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
  int modificationDate;
  int creationDate;
  List<dynamic>? advertisementPayAccount;
  List<dynamic>? advertisementDocuments;
  List<AdvertisementUserInteraction>? advertisementUserInteraction;

  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
