import 'package:json_annotation/json_annotation.dart';

part 'body_validate.g.dart';

@JsonSerializable()
class BodyValidateRegister {
  BodyValidateRegister({
    required this.validateField,
    required this.dataValue,
  });

  factory BodyValidateRegister.fromJson(Map<String, dynamic> json) =>
      _$BodyValidateRegisterFromJson(json);

  String validateField;
  String dataValue;

  Map<String, dynamic> toJson() => _$BodyValidateRegisterToJson(this);
}
