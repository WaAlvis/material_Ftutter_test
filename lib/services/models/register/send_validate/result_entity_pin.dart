import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';

part 'result_entity_pin.g.dart';

@JsonSerializable()
class ResultEntityPin {
  ResultEntityPin(
      {
        required this.clientId,
        required this.numberOrEmail,
        required this.codevia,

});

  factory ResultEntityPin.fromJson(Map<String, dynamic> json) =>
      _$ResultEntityPinFromJson(json);

  String clientId;
  String numberOrEmail;
  String codevia;



  Map<String, dynamic> toJson() => _$ResultEntityPinToJson(this);
}
