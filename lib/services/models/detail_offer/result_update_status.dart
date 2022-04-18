import 'package:json_annotation/json_annotation.dart';

part 'result_update_status.g.dart';

@JsonSerializable()
class ResultUpdateStatus {
  ResultUpdateStatus({
    this.isSucessful,
  });

  factory ResultUpdateStatus.fromJson(Map<String, dynamic> json) =>
      _$ResultUpdateStatusFromJson(json);

  bool? isSucessful;

  Map<String, dynamic> toJson() => _$ResultUpdateStatusToJson(this);
}
