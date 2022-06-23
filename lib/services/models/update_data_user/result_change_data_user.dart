import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';

part 'result_change_data_user.g.dart';

@JsonSerializable()
class ResultChangeDataUser {
  ResultChangeDataUser({
    required this.success,
  });

  factory ResultChangeDataUser.fromJson(Map<String, dynamic> json) =>
      _$ResultChangeDataUserFromJson(json);

  bool success;

  Map<String, dynamic> toJson() => _$ResultChangeDataUserToJson(this);
}
