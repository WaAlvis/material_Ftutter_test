import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_history_operations_user.g.dart';

@JsonSerializable()
class BodyHistoryOperationsUser{

  BodyHistoryOperationsUser({
    required this.idUser,
    required this.pagination,
  });
  factory BodyHistoryOperationsUser.fromJson(Map<String, dynamic> json) =>
      _$BodyHistoryOperationsUserFromJson(json);



  String idUser;
  Pagination pagination;


  Map<String, dynamic> toJson() => _$BodyHistoryOperationsUserToJson(this);
}