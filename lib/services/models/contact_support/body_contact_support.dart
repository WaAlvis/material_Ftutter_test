import 'package:json_annotation/json_annotation.dart';

part 'body_contact_support.g.dart';

@JsonSerializable()
class BodyContactSupport {
  BodyContactSupport({
    required this.id,
    required this.datePublish,
    required this.idUserPublish,
    required this.description,
    required this.idSupportType,
    required this.idSupportStatus,
    required this.idUserSupport,
    required this.dateSolution,
    required this.jiraLink,
    required this.idAdvertisement,
    required this.emailUserPublish,
    required this.userPublishNickname,
    required this.jiraKey,
  });

  factory BodyContactSupport.fromJson(Map<String, dynamic> json) =>
      _$BodyContactSupportFromJson(json);

  String id;
  String datePublish;
  String idUserPublish;
  String description;
  String idSupportType;
  String idSupportStatus;
  String idUserSupport;
  String dateSolution;
  String jiraLink;
  String idAdvertisement;
  String emailUserPublish;
  String userPublishNickname;
  String jiraKey;

  Map<String, dynamic> toJson() => _$BodyContactSupportToJson(this);
}
