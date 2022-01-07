import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';

part 'result_pin_email.g.dart';

@JsonSerializable()
class ResultPinEmail {
  ResultPinEmail(
      {
        required this.entity
});

  factory ResultPinEmail.fromJson(Map<String, dynamic> json) =>
      _$ResultPinEmailFromJson(json);

  EntityPinEmail entity;



  Map<String, dynamic> toJson() => _$ResultPinEmailToJson(this);
}
