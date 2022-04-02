import 'package:json_annotation/json_annotation.dart';

part 'entity_transaction.g.dart';

@JsonSerializable()
class EntityTransaction {
  EntityTransaction({
    required this.message,
    required this.hash,
    required this.advertisementId,
  });
  factory EntityTransaction.fromJson(Map<String, dynamic> json) =>
      _$EntityTransactionFromJson(json);

  String message;
  String hash;
  String advertisementId;

  Map<String, dynamic> toJson() => _$EntityTransactionToJson(this);
}
