import 'package:json_annotation/json_annotation.dart';

part 'body_add_pay_account.g.dart';

@JsonSerializable()
class BodyAddPayAccount {
  BodyAddPayAccount({
    required this.advertisementId,
    required this.strJsonAdvertPayAccount,
  });

  factory BodyAddPayAccount.fromJson(Map<String, dynamic> json) =>
      _$BodyAddPayAccountFromJson(json);

  String advertisementId;
  String strJsonAdvertPayAccount;

  Map<String, dynamic> toJson() => _$BodyAddPayAccountToJson(this);
}
