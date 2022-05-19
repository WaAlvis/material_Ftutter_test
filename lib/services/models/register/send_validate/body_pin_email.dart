import 'package:json_annotation/json_annotation.dart';

part 'body_pin_email.g.dart';

@JsonSerializable()
class BodyPinEmail {
  BodyPinEmail({
    required this.clientId,
    required this.numberOrEmail,
    required this.codevia,
  });

  factory BodyPinEmail.fromJson(Map<String, dynamic> json) =>
      _$BodyPinEmailFromJson(json);

  String clientId;
  String numberOrEmail;
  String codevia;

  Map<String, dynamic> toJson() => _$BodyPinEmailToJson(this);
}
