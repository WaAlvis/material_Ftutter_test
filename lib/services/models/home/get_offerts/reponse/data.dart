import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/user_data_home.dart';

part 'data.g.dart';

@JsonSerializable()
class Data{

  Data({
    required this.user,
    required this.advertisement,

  });
  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  // TokenLogin tokenData;
  // String? user;
   UserDataHome user;
  Advertisement advertisement;




  Map<String, dynamic> toJson() => _$DataToJson(this);
}
