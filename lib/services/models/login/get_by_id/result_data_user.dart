import 'package:json_annotation/json_annotation.dart';

part 'result_data_user.g.dart';

@JsonSerializable()
class ResultDataUser {
  ResultDataUser({
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
  required this.addressWallet,
  required this.dateTimeCreate,
  required this.rateSeller,
  required this.rateBuyer,
  required this.isCorporative,
  required this.indicative,
  });

  factory ResultDataUser.fromJson(Map<String, dynamic> json) =>
      _$ResultDataUserFromJson(json);

  String id;
  String nickName;
  String firstName;
  String secondName;
  String firstLastName;
  String secondLastName;
  String dateBirth;
  String email;
  int indicative;
  String phone;
  String userTypeId;
  String password;
  bool isActive;
  String addressWallet;
  String dateTimeCreate;
  String rateSeller;
  String rateBuyer;
  bool isCorporative;

  Map<String, dynamic> toJson() => _$ResultDataUserToJson(this);
}
