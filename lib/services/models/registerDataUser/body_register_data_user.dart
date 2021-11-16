import 'package:json_annotation/json_annotation.dart';

part 'body_register_data_user.g.dart';

@JsonSerializable()
class BodyRegisterDataUser{

  BodyRegisterDataUser({required this.identity, required this.password, required this.signature, required this.wearableId});
  factory BodyRegisterDataUser.fromJson(Map<String, dynamic> json) =>
      _$BodyRegisterDataUserFromJson(json);

  String identity;
  String password;
  String signature;
  String wearableId;

  Map<String, dynamic> toJson() => _$BodyRegisterDataUserToJson(this);
}