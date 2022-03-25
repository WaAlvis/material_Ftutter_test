import 'package:json_annotation/json_annotation.dart';

part 'body_register_data_user.g.dart';

@JsonSerializable()
class BodyRegisterDataUser {
  BodyRegisterDataUser({
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
    required this.addressWallet,

      });

  factory BodyRegisterDataUser.fromJson(Map<String, dynamic> json) =>
      _$BodyRegisterDataUserFromJson(json);

  String addressWallet;
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

  Map<String, dynamic> toJson() => _$BodyRegisterDataUserToJson(this);
}