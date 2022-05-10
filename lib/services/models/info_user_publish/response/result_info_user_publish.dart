import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';

part 'result_info_user_publish.g.dart';

@JsonSerializable()
class ResultInfoUserPublish {
  ResultInfoUserPublish({
    required this.numberOfSales,
    required this.numberOfBuys,
    required this.rateGeneral,
    required this.openSales,
    required this.openBuys,
  });

  factory ResultInfoUserPublish.fromJson(Map<String, dynamic> json) =>
      _$ResultInfoUserPublishFromJson(json);

  int numberOfSales;
  int numberOfBuys;
  double rateGeneral;
  int openSales;
  int openBuys;

  Map<String, dynamic> toJson() => _$ResultInfoUserPublishToJson(this);
}
