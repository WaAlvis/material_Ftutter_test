import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/transaction/entity_transaction.dart';

part 'body_createtransaction.g.dart';

@JsonSerializable()
class BodyCreateTransaction {
  BodyCreateTransaction({required this.entity, required this.strJsonMovements});
  factory BodyCreateTransaction.fromJson(Map<String, dynamic> json) =>
      _$BodyCreateTransactionFromJson(json);

  EntityTransaction entity;
  String strJsonMovements;

  Map<String, dynamic> toJson() => _$BodyCreateTransactionToJson(this);
}
