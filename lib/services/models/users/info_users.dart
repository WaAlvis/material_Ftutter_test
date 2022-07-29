import 'package:json_annotation/json_annotation.dart';

part 'info_users.g.dart';

@JsonSerializable()
class InfoUsers {
  InfoUsers({
    this.id,
    this.nickName,
    this.firstName,
    this.secondName,
    this.firstLastName,
    this.secondLastName,
    this.dateBirth,
    this.email,
    this.phone,
    this.userTypeId,
    this.password,
    this.isActive,
  });
  factory InfoUsers.fromJson(Map<String, dynamic> json) =>
      _$InfoUsersFromJson(json);
  String? id;
  String? nickName;
  String? firstName;
  String? secondName;
  String? firstLastName;
  String? secondLastName;
  String? dateBirth;
  String? email;
  String? phone;
  String? userTypeId;
  String? password;
  bool? isActive;
  Map<String, dynamic> toJson() => _$InfoUsersToJson(this);
}
