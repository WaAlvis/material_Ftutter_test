import 'package:json_annotation/json_annotation.dart';

part 'result_register.g.dart';

@JsonSerializable()
class ResultRegister{

  ResultRegister({
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
  factory ResultRegister.fromJson(Map<String, dynamic> json) =>
      _$ResultRegisterFromJson(json);

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

  Map<String, dynamic> toJson() => _$ResultRegisterToJson(this);
}
