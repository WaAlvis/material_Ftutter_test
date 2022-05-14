import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable()
class Filters {
  Filters({
    required this.typeAdvertisement,
    required this.idUserPublish,
    required this.statusCode,
    required this.idUserExclusion,
    required this.idUserInteraction,
    required this.strJsonExtraFilters,
  });

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  String typeAdvertisement;
  String idUserPublish;
  String statusCode;
  String idUserExclusion;
  String idUserInteraction;
  String strJsonExtraFilters;

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}
