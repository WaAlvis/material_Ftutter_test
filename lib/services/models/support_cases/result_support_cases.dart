import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';

part 'result_support_cases.g.dart';

@JsonSerializable()
class ResultSupportCases {
  ResultSupportCases({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultSupportCases.fromJson(Map<String, dynamic> json) =>
      _$ResultSupportCasesFromJson(json);

  List<BodyContactSupport> data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultSupportCasesToJson(this);
}
