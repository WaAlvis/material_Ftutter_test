import 'package:json_annotation/json_annotation.dart';

part 'result_validate_pin.g.dart';

@JsonSerializable()
class ResultValidatePin {
  ResultValidatePin(
      {
        required this.sid,
        required this.serviceSid,
        required this.accountSid,
        required this.to,
        required this.channel,
        required this.status,
        required this.valid,
        required this.amount,
        required this.payee,
        required this.dateCreated,
        required this.dateUpdated,
});

  factory ResultValidatePin.fromJson(Map<String, dynamic> json) =>
      _$ResultValidatePinFromJson(json);

  String sid;
  String serviceSid;
  String accountSid;
  String to;
  Object channel;
  String status;
  bool valid;
  bool? amount;
  bool? payee;
  String dateCreated;
  String dateUpdated;


  Map<String, dynamic> toJson() => _$ResultValidatePinToJson(this);
}
