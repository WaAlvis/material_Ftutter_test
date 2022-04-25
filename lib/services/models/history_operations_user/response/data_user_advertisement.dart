import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/history_operations_user/response/advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/user.dart';

part 'data_user_advertisement.g.dart';

@JsonSerializable()
class DataUserAdvertisement{

 DataUserAdvertisement({
   required this.user,
   required this.advertisement,

 });
  factory DataUserAdvertisement.fromJson(Map<String, dynamic> json) =>
      _$DataUserAdvertisementFromJson(json);

  User user;
 Advertisement advertisement;

  Map<String, dynamic> toJson() => _$DataUserAdvertisementToJson(this);
}