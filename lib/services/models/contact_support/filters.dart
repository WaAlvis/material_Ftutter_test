import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable()
class Filters {
  Filters({
    required this.id,
    required this.description,
    required this.code,
  });

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  String id;
  String description;
  String code;

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}
