import 'package:json_annotation/json_annotation.dart';

part 'advertisement_document.g.dart';

@JsonSerializable()
class AdvertisementDocument {
  AdvertisementDocument({
    required this.id,
    required this.advertisementId,
    required this.userId,
    required this.documentRoute,
    required this.creationDate,
    required this.fileExtension,
  });

  factory AdvertisementDocument.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementDocumentFromJson(json);

  String id;
  String advertisementId;
  String userId;
  String documentRoute;
  int creationDate;
  String fileExtension;

  Map<String, dynamic> toJson() => _$AdvertisementDocumentToJson(this);
}
