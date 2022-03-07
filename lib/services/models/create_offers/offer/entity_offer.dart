import 'package:json_annotation/json_annotation.dart';

part 'entity_offer.g.dart';

@JsonSerializable()
class EntityOffer {
  EntityOffer({
    required this.idTypeAdvertisement,
    required this.idCountry,
    required this.valueToSell,
    required this.margin,
    required this.termsOfTrade,
    required this.idUserPublish,
    required this.secretSellerKey,
  });

  factory EntityOffer.fromJson(Map<String, dynamic> json) =>
      _$EntityOfferFromJson(json);

  String idTypeAdvertisement;
  String idCountry;
  String valueToSell;
  String margin;
  String termsOfTrade;
  String idUserPublish;
  String secretSellerKey;


  Map<String, dynamic> toJson() => _$EntityOfferToJson(this);
}
