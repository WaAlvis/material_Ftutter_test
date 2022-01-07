import 'package:json_annotation/json_annotation.dart';

part 'entity_response_validate_pin.g.dart';

@JsonSerializable()
class EntityResponseValidatePin {
  EntityResponseValidatePin({
    required this.id,
    required this.clientId,
    required this.numberOrEmail,
    required this.otp,
  });

  factory EntityResponseValidatePin.fromJson(Map<String, dynamic> json) =>
      _$EntityResponseValidatePinFromJson(json);

  String id;
  String clientId;
  String numberOrEmail;
  String otp;

  Map<String, dynamic> toJson() => _$EntityResponseValidatePinToJson(this);
}
