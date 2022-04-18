import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Data({
    required this.id,
    required this.description,
    required this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  String id;
  String description;
  int code;

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
