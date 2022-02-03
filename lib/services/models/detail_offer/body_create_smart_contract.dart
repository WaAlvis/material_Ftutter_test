import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/detail_offer/smart_contract.dart';

part 'body_create_smart_contract.g.dart';

@JsonSerializable()
class BodyCreateSmartContract {
  BodyCreateSmartContract({
    required this.smartContract,
    required this.advertisement,

      });

  factory BodyCreateSmartContract.fromJson(Map<String, dynamic> json) =>
      _$BodyCreateSmartContractFromJson(json);

  SmartContract smartContract;
  Advertisement advertisement;


  Map<String, dynamic> toJson() => _$BodyCreateSmartContractToJson(this);
}