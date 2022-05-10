import 'package:json_annotation/json_annotation.dart';

part 'rate_user.g.dart';

@JsonSerializable()
class RateUser {
  RateUser({
    required this.isSeller,
    required this.userId,
    required this.rate,
    required this.advertisementId,
    required this.isOper,
  });

  factory RateUser.fromJson(Map<String, dynamic> json) =>
      _$RateUserFromJson(json);

  bool isSeller;
  String userId;
  String rate;
  String advertisementId;
  String isOper;

  Map<String, dynamic> toJson() => _$RateUserToJson(this);
}
