import 'package:json_annotation/json_annotation.dart';

part 'result_pin_email.g.dart';

@JsonSerializable()
class ResultPinEmail {
  ResultPinEmail({
    required this.clientId,
    required this.numberOrEmail,
    required this.codevia,
  });

  factory ResultPinEmail.fromJson(Map<String, dynamic> json) =>
      _$ResultPinEmailFromJson(json);

  String clientId;
  String numberOrEmail;
  String codevia;

  Map<String, dynamic> toJson() => _$ResultPinEmailToJson(this);
}
