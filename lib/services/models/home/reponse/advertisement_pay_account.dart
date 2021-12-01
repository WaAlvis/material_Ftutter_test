import 'package:json_annotation/json_annotation.dart';

part 'advertisement_pay_account.g.dart';

@JsonSerializable()
class AdvertisementPayAccount {
  AdvertisementPayAccount({
    required this.id,
    required this.bankId,
    required this.advertisementId,
    required this.accountNumber,
    required this.accountTypeId,
    required this.documentNumber,
    required this.titularUserName,
  });

  factory AdvertisementPayAccount.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementPayAccountFromJson(json);

  String id;
  String bankId;
  String advertisementId;
  String accountNumber;
  String accountTypeId;
  String documentNumber;
  String titularUserName;

  Map<String, dynamic> toJson() => _$AdvertisementPayAccountToJson(this);
}
