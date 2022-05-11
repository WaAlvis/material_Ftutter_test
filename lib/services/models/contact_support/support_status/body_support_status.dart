import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/filters.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_support_status.g.dart';

@JsonSerializable()
class BodySupportStatus {
  BodySupportStatus({
    required this.filters,
    required this.pagination,
  });

  factory BodySupportStatus.fromJson(Map<String, dynamic> json) =>
      _$BodySupportStatusFromJson(json);

  Filters filters;
  Pagination pagination;

  Map<String, dynamic> toJson() => _$BodySupportStatusToJson(this);
}
