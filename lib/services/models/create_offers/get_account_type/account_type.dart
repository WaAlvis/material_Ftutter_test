import 'package:json_annotation/json_annotation.dart';

part 'account_type.g.dart';

@JsonSerializable()
class AccountType {
  AccountType({
    required this.id,
    required this.description,
  });

  factory AccountType.fromJson(Map<String, dynamic> json) =>
      _$AccountTypeFromJson(json);

  String id;
  String description;

  Map<String, dynamic> toJson() => _$AccountTypeToJson(this);
}
