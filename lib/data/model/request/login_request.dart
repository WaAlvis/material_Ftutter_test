import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
//UserRequest??
class LoginRequest {

  late  String? email;
  late  String? password;

  LoginRequest(this.email, this.password ,);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);


  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}