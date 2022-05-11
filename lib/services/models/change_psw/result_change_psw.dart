import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/matrix_user_result_login.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/login/user_login.dart';

part 'result_change_psw.g.dart';

@JsonSerializable()
class ResultChangePsw {
  ResultChangePsw({
    required this.success,
  });

  factory ResultChangePsw.fromJson(Map<String, dynamic> json) =>
      _$ResultChangePswFromJson(json);

  bool success;

  Map<String, dynamic> toJson() => _$ResultChangePswToJson(this);
}
