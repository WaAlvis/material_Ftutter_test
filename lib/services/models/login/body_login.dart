import 'package:json_annotation/json_annotation.dart';

part 'body_login.g.dart';

@JsonSerializable()
class BodyLogin{

  BodyLogin({required this.identity, required this.password, required this.signature, required this.wearableId});
  factory BodyLogin.fromJson(Map<String, dynamic> json) =>
      _$BodyLoginFromJson(json);

  String identity;
  String password;
  String signature;
  String wearableId;

  Map<String, dynamic> toJson() => _$BodyLoginToJson(this);
}