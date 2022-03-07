import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';
import 'package:localdaily/services/models/register/send_validate/result_entity_pin.dart';

part 'result_pin_email.g.dart';

@JsonSerializable()
class ResultPinEmail {
  ResultPinEmail(
      {
        required this.entity
});

  factory ResultPinEmail.fromJson(Map<String, dynamic> json) =>
      _$ResultPinEmailFromJson(json);

  ResultEntityPin entity;



  Map<String, dynamic> toJson() => _$ResultPinEmailToJson(this);
}
