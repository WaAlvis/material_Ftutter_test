import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';

part 'body_offer.g.dart';

@JsonSerializable()
class BodyOffer {
  BodyOffer({
    required this.entity,
    required this.daysOfExpired,
    required this.strJsonAdvertisementBanks,

      });

  factory BodyOffer.fromJson(Map<String, dynamic> json) =>
      _$BodyOfferFromJson(json);

  EntityOffer entity;
  int daysOfExpired;
  String strJsonAdvertisementBanks;


  Map<String, dynamic> toJson() => _$BodyOfferToJson(this);
}