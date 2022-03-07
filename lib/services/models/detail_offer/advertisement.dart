import 'package:json_annotation/json_annotation.dart';

part 'advertisement.g.dart';

@JsonSerializable()
class Advertisement {
  Advertisement({
      required this.idAdvertisement,
      required this.idUserInteraction,
      required this.statusOrigin,
      required this.statusDestiny,
      required this.successfulTransaction,

      });

  factory Advertisement.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementFromJson(json);

  String idAdvertisement;
  String idUserInteraction;
  int statusOrigin;
  int statusDestiny;
  bool successfulTransaction;



  Map<String, dynamic> toJson() => _$AdvertisementToJson(this);
}
