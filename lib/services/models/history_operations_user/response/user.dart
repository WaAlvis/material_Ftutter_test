import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'user.g.dart';

@JsonSerializable()
class User{

 User({
   required this.nickName,
   required this.rateSeller,
   required this.rateBuyer,
   required this.address,
 });
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

 String nickName;
 double rateSeller;
 double rateBuyer;
 String address;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}