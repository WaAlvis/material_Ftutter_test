import 'package:json_annotation/json_annotation.dart';

part 'token_login.g.dart';

@JsonSerializable()
class TokenLogin{

  TokenLogin({required this.token, required this.refreshToken,
    required this.expiryDate,
  });
  factory TokenLogin.fromJson(Map<String, dynamic> json) =>
      _$TokenLoginFromJson(json);

  String token;
  String refreshToken;
  String expiryDate;

  Map<String, dynamic> toJson() => _$TokenLoginToJson(this);
}