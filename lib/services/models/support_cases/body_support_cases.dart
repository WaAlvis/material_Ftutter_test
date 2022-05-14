import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_support_cases.g.dart';

@JsonSerializable()
class BodySupportCases {
  BodySupportCases({
    required this.filters,
    required this.pagination,
  });

  factory BodySupportCases.fromJson(Map<String, dynamic> json) =>
      _$BodySupportCasesFromJson(json);

  BodyContactSupport filters;
  Pagination pagination;

  Map<String, dynamic> toJson() => _$BodySupportCasesToJson(this);
}
