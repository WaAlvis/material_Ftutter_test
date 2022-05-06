import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'advertisement_user_interaction.g.dart';

@JsonSerializable()
class AdvertisementUserInteraction {
  AdvertisementUserInteraction({
    required this.id,
    required this.idAdvertisement,
    required this.idUser,
    required this.processCompleted,
    required this.value,
    required this.expirationDate,
  });

  factory AdvertisementUserInteraction.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementUserInteractionFromJson(json);

  String id;
  String idAdvertisement;
  String idUser;
  bool processCompleted;
  int value;
  String expirationDate;

  Map<String, dynamic> toJson() => _$AdvertisementUserInteractionToJson(this);
}
