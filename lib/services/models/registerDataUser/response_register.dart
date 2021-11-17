import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'response_register.g.dart';

@JsonSerializable()
class ResponseRegister{

  ResponseRegister({
    required this.id,
    required this.nickName,
    required this.firstName,
    required this.secondName,
    required this.firstLastName,
    required this.secondLastName,
    required this.dateBirth,
    required this.email,
    required this.phone,
    required this.userTypeId,
    required this.password,
    required this.isActive,
  });
  factory ResponseRegister.fromJson(Map<String, dynamic> json) =>
      _$ResponseRegisterFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  String id;
  String nickName;
  String firstName;
  String secondName;
  String firstLastName;
  String secondLastName;
  String dateBirth;
  String email;
  String phone;
  String userTypeId;
  String password;
  bool isActive;

  Map<String, dynamic> toJson() => _$ResponseRegisterToJson(this);
}