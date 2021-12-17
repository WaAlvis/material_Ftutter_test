import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'permissions_matrix.g.dart';
//Esta Matris no se esta usando para el result del Login
//Revisar con Duvan y Roger
@JsonSerializable()
class PermissionsMatrix {
  PermissionsMatrix({
    required this.id,
    required this.name,
    required this.method,
    required this.urlBase,
    required this.endPoint,
  });

  factory PermissionsMatrix.fromJson(Map<String, dynamic> json) =>
      _$PermissionsMatrixFromJson(json);

  String id;
  String name;
  String method;
  String urlBase;
  String endPoint;

  Map<String, dynamic> toJson() => _$PermissionsMatrixToJson(this);
}
