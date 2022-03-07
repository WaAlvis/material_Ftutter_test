import 'package:json_annotation/json_annotation.dart';

part 'user_login.g.dart';

@JsonSerializable()
class UserLogin {
  UserLogin({
    required this.id,
    required this.firstLastName,
    required this.firstName,
    required this.indicative,
    required this.mobile,
    required this.secondLastName,
    required this.secondName,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  String id;
  String firstLastName;
  String firstName;
  String indicative;
  String mobile;
  String secondLastName;
  String secondName;

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}
