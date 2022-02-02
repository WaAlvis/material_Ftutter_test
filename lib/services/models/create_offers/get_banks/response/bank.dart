import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank {
  Bank(
      {required this.id,
      required this.countryId,
      required this.description,
      required this.isActive});

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  String id;
  String countryId;
  String description;
  bool isActive;

  Map<String, dynamic> toJson() => _$BankToJson(this);
}
