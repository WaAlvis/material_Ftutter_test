import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/response/info_login_error.dart';

part 'response_error_register.g.dart';

@JsonSerializable()
class ResponseErrorRegister{
  ResponseErrorRegister({required this.message, this.info});

  factory ResponseErrorRegister.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorRegisterFromJson(json);

  String message;
  InfoLoginError? info;

  Map<String, dynamic> toJson() => _$ResponseErrorRegisterToJson(this);
}
