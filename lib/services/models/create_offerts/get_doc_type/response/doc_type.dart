import 'package:json_annotation/json_annotation.dart';

part 'doc_type.g.dart';


@JsonSerializable()
class DocType {
  DocType(
      {required this.id,
        required this.countryId,
        required this.description,
        required this.isActive});

  factory DocType.fromJson(Map<String, dynamic> json) => _$DocTypeFromJson(json);

  String id;
  String countryId;
  String description;
  bool isActive;

  Map<String, dynamic> toJson() => _$DocTypeToJson(this);
}
