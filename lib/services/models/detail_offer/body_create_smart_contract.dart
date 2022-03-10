import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/detail_offer/smart_contract.dart';

part 'body_create_smart_contract.g.dart';

@JsonSerializable()
class BodyCreateSmartContract {
  BodyCreateSmartContract({
    required this.smartContract,
    required this.advertisement,
    required this.typeAdvertisementInfo,
  });

  factory BodyCreateSmartContract.fromJson(Map<String, dynamic> json) =>
      _$BodyCreateSmartContractFromJson(json);

  SmartContract smartContract;
  Advertisement advertisement;
  int typeAdvertisementInfo;

  Map<String, dynamic> toJson() => _$BodyCreateSmartContractToJson(this);
}
