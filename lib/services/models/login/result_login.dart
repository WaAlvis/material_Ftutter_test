import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'result_login.g.dart';

@JsonSerializable()
class ResultLogin{

  ResultLogin({required this.tokenData, this.user});
  factory ResultLogin.fromJson(Map<String, dynamic> json) =>
      _$ResultLoginFromJson(json);

  TokenLogin tokenData;
  String? user;

  Map<String, dynamic> toJson() => _$ResultLoginToJson(this);
}
