import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/options_matrix.dart';
import 'package:localdaily/services/models/login/permissions_matrix.dart';

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
    this.permissions,
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
  List<PermissionsMatrix>? permissions;
  List<OptionsMatrix>? options;

  Map<String, dynamic> toJson() => _$MatrixUserResultLoginToJson(this);
}
