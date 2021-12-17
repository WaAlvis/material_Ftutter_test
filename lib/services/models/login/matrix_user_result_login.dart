import 'package:json_annotation/json_annotation.dart';

part 'matrix_user_result_login.g.dart';

@JsonSerializable()
class MatrixUserResultLogin {
  MatrixUserResultLogin({
    required this.applicationId,
    required this.applicationName,
    required this.moduleId,
    required this.moduleName,
    required this.roleId,
    required this.roleName,
    required this.permissionId,
    required this.permission,
    this.options,
  });

  factory MatrixUserResultLogin.fromJson(Map<String, dynamic> json) =>
      _$MatrixUserResultLoginFromJson(json);

  String applicationId;
  String applicationName;
  String moduleId;
  String moduleName;
  String roleId;
  String roleName;
  String permissionId;
  String permission;
  List<String>? options;

  Map<String, dynamic> toJson() => _$MatrixUserResultLoginToJson(this);
}
