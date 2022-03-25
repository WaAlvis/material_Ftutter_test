import 'package:json_annotation/json_annotation.dart';

part 'smart_contract.g.dart';

@JsonSerializable()
class SmartContract {
  SmartContract({
    required this.amount,
    required this.addressSeller,
    required this.addressBuyer,
    this.doubleHashedSecretsOfSeller,
    this.doubleHashedSecretsOfBuyer,
    this.doubleHashedSecretsOfArbitrator,
    this.salt,
  });

  factory SmartContract.fromJson(Map<String, dynamic> json) =>
      _$SmartContractFromJson(json);

  String amount;
  String addressSeller;
  String addressBuyer;
  String? doubleHashedSecretsOfSeller;
  String? doubleHashedSecretsOfBuyer;
  String? doubleHashedSecretsOfArbitrator;
  String? salt;

  Map<String, dynamic> toJson() => _$SmartContractToJson(this);
}
