import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'user_data_home.g.dart';

@JsonSerializable()
class UserDataHome{

  UserDataHome({
    required this.nickName,
    required this.rateSeller,
    required this.rateBuyer,

  });
  factory UserDataHome.fromJson(Map<String, dynamic> json) =>
      _$UserDataHomeFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  String nickName;
  String rateSeller;
  String rateBuyer;






  Map<String, dynamic> toJson() => _$UserDataHomeToJson(this);
}