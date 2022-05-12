import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/data_support.dart';

part 'result_support_type.g.dart';

@JsonSerializable()
class ResultSupportType {
  ResultSupportType({
    required this.data,
  });

  factory ResultSupportType.fromJson(Map<String, dynamic> json) =>
      _$ResultSupportTypeFromJson(json);

  List<DataSupport> data;

  Map<String, dynamic> toJson() => _$ResultSupportTypeToJson(this);
}
