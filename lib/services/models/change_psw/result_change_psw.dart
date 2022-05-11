import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';

part 'result_recover_psw.g.dart';

@JsonSerializable()
class ResultRecoverPsw {
  ResultRecoverPsw({
    required this.success,
  });

  factory ResultRecoverPsw.fromJson(Map<String, dynamic> json) =>
      _$ResultRecoverPswFromJson(json);

  bool success;

  Map<String, dynamic> toJson() => _$ResultRecoverPswToJson(this);
}
