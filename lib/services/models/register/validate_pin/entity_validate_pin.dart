import 'package:json_annotation/json_annotation.dart';

part 'entity_validate_pin.g.dart';

@JsonSerializable()
class EntityValidatePin {
  EntityValidatePin({
    required this.numberOrEmail,
    required this.otp,

  });

  factory EntityValidatePin.fromJson(Map<String, dynamic> json) => _$EntityValidatePinFromJson(json);

  String numberOrEmail;
  String otp;


  Map<String, dynamic> toJson() => _$EntityValidatePinToJson(this);
}
