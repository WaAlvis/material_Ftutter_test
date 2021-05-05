import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
//UserRequest??
class LoginRequest {

  late  String? username;
  late  String? password;

  LoginRequest(this.username, this.password ,);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);


  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}