import 'package:json_annotation/json_annotation.dart';

part 'user_data_home.g.dart';

@JsonSerializable()
class UserDataHome {
  UserDataHome({
    required this.nickName,
    required this.rateSeller,
    required this.rateBuyer,
    required this.address,
  });
  factory UserDataHome.fromJson(Map<String, dynamic> json) =>
      _$UserDataHomeFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  String nickName;
  double rateSeller;
  double rateBuyer;
  String address;

  Map<String, dynamic> toJson() => _$UserDataHomeToJson(this);
}
