import 'package:json_annotation/json_annotation.dart';

part '../type_doc.g.dart';

@JsonSerializable()
class TypeDoc {
  TypeDoc(
      {required this.id,
        required this.countryId,
        required this.description,
        required this.isActive});

  factory TypeDoc.fromJson(Map<String, dynamic> json) => _$TypeDocFromJson(json);

  String id;
  String countryId;
  String description;
  bool isActive;

  Map<String, dynamic> toJson() => _$TypeDocToJson(this);
}
