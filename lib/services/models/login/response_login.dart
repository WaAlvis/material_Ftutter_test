import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'response_login.g.dart';

@JsonSerializable()
class ResponseLogin{

  ResponseLogin({required this.tokenData, this.user});
  factory ResponseLogin.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginFromJson(json);

  TokenLogin tokenData;
  String? user;

  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);
}