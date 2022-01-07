import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/advertisement_pay_account.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';
import 'package:localdaily/services/models/register/pin_validate/entity_pin_email.dart';

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
