import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part '../response_register.g.dart';

@JsonSerializable()
class ResultHome{

  ResultHome({
    required this.isSuccess,
    required this.statusCode,

  });
  factory ResultHome.fromJson(Map<String, dynamic> json) =>
      _$ResultHomeFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  String isSuccess;
  String statusCode;
   result;



  Map<String, dynamic> toJson() => _$ResultHomeToJson(this);
}