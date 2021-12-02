import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class Entity {
  Entity({
    required this.idTypeAdvertisement,
    required this.idCountry,
    required this.valueToSell,
    required this.margin,
    required this.termsOfTrade,
    required this.idUserPublish,


  });

  factory Entity.fromJson(Map<String, dynamic> json) =>
      _$EntityFromJson(json);

  String idTypeAdvertisement;
  String idCountry;
  String valueToSell;
  String margin;
  String termsOfTrade;
  String idUserPublish;


  Map<String, dynamic> toJson() => _$EntityToJson(this);
}
