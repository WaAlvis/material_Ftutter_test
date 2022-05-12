import 'package:json_annotation/json_annotation.dart';

part 'body_contact_support.g.dart';

@JsonSerializable()
class BodyContactSupport {
  BodyContactSupport({
    this.id,
    this.datePublish,
    required this.idUserPublish,
    required this.description,
    required this.idSupportType,
    this.idSupportStatus,
    this.idUserSupport,
    this.dateSolution,
    this.jiraLink,
    required this.idPublish,
    required this.email,
  });

  factory BodyContactSupport.fromJson(Map<String, dynamic> json) =>
      _$BodyContactSupportFromJson(json);

  String? id;
  String? datePublish;
  String idUserPublish;
  String description;
  String idSupportType;
  String? idSupportStatus;
  String? idUserSupport;
  String? dateSolution;
  String? jiraLink;
  String idPublish;
  String email;

  Map<String, dynamic> toJson() => _$BodyContactSupportToJson(this);
}
