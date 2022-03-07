import 'package:json_annotation/json_annotation.dart';

part 'result_create_smart_contract.g.dart';

@JsonSerializable()
class ResultCreateSmartContract {
  ResultCreateSmartContract({
      required this.id,
      required this.date,
      required this.transactionStatusId,
      required this.hash,
      required this.advertisementId,
      required this.contractAddress,
      required this.addressSeller,
      required this.addressBuyer,
      required this.code,
      required this.message,

      });

  factory ResultCreateSmartContract.fromJson(Map<String, dynamic> json) =>
      _$ResultCreateSmartContractFromJson(json);


 String id;
 String date;
 String transactionStatusId;
 String hash;
 String advertisementId;
 String contractAddress;
 String addressSeller;
 String addressBuyer;
 String code;
 String message;


  Map<String, dynamic> toJson() => _$ResultCreateSmartContractToJson(this);
}
