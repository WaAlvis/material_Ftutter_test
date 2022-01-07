import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';

part 'body_pin_email.g.dart';

@JsonSerializable()
class BodyPinEmail {
  BodyPinEmail({
    required this.entity,
  });

  factory BodyPinEmail.fromJson(Map<String, dynamic> json) =>
      _$BodyPinEmailFromJson(json);

  EntityPinEmail entity;

  Map<String, dynamic> toJson() => _$BodyPinEmailToJson(this);
}
