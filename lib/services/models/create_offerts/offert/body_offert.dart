import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offerts/offert/entity.dart';

part 'body_offert.g.dart';

@JsonSerializable()
class BodyOffert {
  BodyOffert({
    required this.entity,
    required this.daysOfExpired,
    required this.strJsonAdvertisementBanks,

      });

  factory BodyOffert.fromJson(Map<String, dynamic> json) =>
      _$BodyOffertFromJson(json);

  Entity entity;
  int daysOfExpired;
  String strJsonAdvertisementBanks;


  Map<String, dynamic> toJson() => _$BodyOffertToJson(this);
}