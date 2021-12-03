import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';

part 'result_create_offert.g.dart';

@JsonSerializable()
class ResultCreateOffert {
  ResultCreateOffert(
      {required this.tokenData, required this.user, this.matrix});

  factory ResultCreateOffert.fromJson(Map<String, dynamic> json) =>
      _$ResultCreateOffertFromJson(json);

  TokenLogin tokenData;
  UserLogin user;
  List<MatrixUserResultLogin>? matrix;

  Map<String, dynamic> toJson() => _$ResultCreateOffertToJson(this);
}
