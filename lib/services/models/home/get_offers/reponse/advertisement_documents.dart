import 'package:json_annotation/json_annotation.dart';

part 'advertisement_documents.g.dart';

@JsonSerializable()
class AdvertisementDocuments {
  AdvertisementDocuments({
    required this.id,
    required this.advertisementId,
    required this.documentRoute,
    required this.creationDate,
  });

  factory AdvertisementDocuments.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementDocumentsFromJson(json);

  String id;
  String advertisementId;
  String documentRoute;
  int creationDate;

  Map<String, dynamic> toJson() => _$AdvertisementDocumentsToJson(this);
}
