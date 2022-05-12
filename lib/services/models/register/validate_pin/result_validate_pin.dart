import 'package:json_annotation/json_annotation.dart';

part 'result_validate_pin.g.dart';

@JsonSerializable()
class ResultValidatePin {
  ResultValidatePin(
      {
        required this.to,
        required this.status,
        required this.valid,
        required this.dateCreate,
        required this.dateUpdated,

});

  factory ResultValidatePin.fromJson(Map<String, dynamic> json) =>
      _$ResultValidatePinFromJson(json);

  String to;
  String status;
  bool valid;
  String dateCreate;
  String dateUpdated;



  Map<String, dynamic> toJson() => _$ResultValidatePinToJson(this);
}
