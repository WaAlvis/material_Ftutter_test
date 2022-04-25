import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';

part 'result_history_operations_user.g.dart';

@JsonSerializable()
class ResultHistoryOperationsUser {
  ResultHistoryOperationsUser({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultHistoryOperationsUser.fromJson(Map<String, dynamic> json) =>
      _$ResultHistoryOperationsUserFromJson(json);

  List<DataUserAdvertisement> data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultHistoryOperationsUserToJson(this);
}
