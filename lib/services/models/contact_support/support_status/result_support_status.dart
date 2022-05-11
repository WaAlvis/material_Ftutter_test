import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/data_support.dart';

part 'result_support_status.g.dart';

@JsonSerializable()
class ResultSupportStatus {
  ResultSupportStatus({
    required this.data,
  });

  factory ResultSupportStatus.fromJson(Map<String, dynamic> json) =>
      _$ResultSupportStatusFromJson(json);

  List<DataSupport> data;

  Map<String, dynamic> toJson() => _$ResultSupportStatusToJson(this);
}
