import 'package:json_annotation/json_annotation.dart';

part 'entity_pin_email.g.dart';

@JsonSerializable()
class EntityPinEmail {
  EntityPinEmail({
    required this.numberOrEmail,
    required this.codevia,

  });

  factory EntityPinEmail.fromJson(Map<String, dynamic> json) => _$EntityPinEmailFromJson(json);

  String numberOrEmail;
  String codevia;

  Map<String, dynamic> toJson() => _$EntityPinEmailToJson(this);
}
