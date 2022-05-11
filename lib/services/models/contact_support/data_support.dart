import 'package:json_annotation/json_annotation.dart';

part 'data_support.g.dart';

@JsonSerializable()
class DataSupport {
  DataSupport({
    required this.id,
    required this.description,
    required this.code,
  });

  factory DataSupport.fromJson(Map<String, dynamic> json) =>
      _$DataSupportFromJson(json);

  String id;
  String description;
  String code;

  Map<String, dynamic> toJson() => _$DataSupportToJson(this);
}
