import 'package:json_annotation/json_annotation.dart';

part 'body_change_psw.g.dart';

@JsonSerializable()
class BodyChangePsw {
  BodyChangePsw({
    required this.clientId,
    required this.userId,
    required this.password,
    required this.newPassword,
  });

  factory BodyChangePsw.fromJson(Map<String, dynamic> json) =>
      _$BodyChangePswFromJson(json);

  String clientId;
  String userId;
  String password;
  String newPassword;

  Map<String, dynamic> toJson() => _$BodyChangePswToJson(this);
}
