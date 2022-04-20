import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';

part 'result_account_type.g.dart';

@JsonSerializable()
class ResultAccountType {
  ResultAccountType({
    required this.entity,
  });

  factory ResultAccountType.fromJson(Map<String, dynamic> json) =>
      _$ResultAccountTypeFromJson(json);

  List<AccountType> entity;

  Map<String, dynamic> toJson() => _$ResultAccountTypeToJson(this);
}
