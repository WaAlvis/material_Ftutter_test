import 'package:json_annotation/json_annotation.dart';

part 'body_new_data_user.g.dart';

@JsonSerializable()
class BodyNewDataUser {
  BodyNewDataUser({required this.id, required this.newValue});
  factory BodyNewDataUser.fromJson(Map<String, dynamic> json) =>
      _$BodyNewDataUserFromJson(json);

  String id;
  String newValue;


  Map<String, dynamic> toJson() => _$BodyNewDataUserToJson(this);
}
