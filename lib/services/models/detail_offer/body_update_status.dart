import 'package:json_annotation/json_annotation.dart';

part 'body_update_status.g.dart';

@JsonSerializable()
class BodyUpdateStatus {
  BodyUpdateStatus({
    required this.idAdvertisement,
    required this.idUserInteraction,
    required this.statusOrigin,
    required this.statusDestiny,
    required this.successfulTransaction,
  });

  factory BodyUpdateStatus.fromJson(Map<String, dynamic> json) =>
      _$BodyUpdateStatusFromJson(json);

  String idAdvertisement;
  String idUserInteraction;
  int statusOrigin;
  int statusDestiny;
  bool successfulTransaction;

  Map<String, dynamic> toJson() => _$BodyUpdateStatusToJson(this);
}
