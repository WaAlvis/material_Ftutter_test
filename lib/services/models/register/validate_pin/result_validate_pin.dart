import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/entity_response_validate_pin.dart';

part 'result_validate_pin.g.dart';

@JsonSerializable()
class ResultValidatePin {
  ResultValidatePin(
      {
        required this.entity
});

  factory ResultValidatePin.fromJson(Map<String, dynamic> json) =>
      _$ResultValidatePinFromJson(json);

  EntityResponseValidatePin entity;



  Map<String, dynamic> toJson() => _$ResultValidatePinToJson(this);
}
