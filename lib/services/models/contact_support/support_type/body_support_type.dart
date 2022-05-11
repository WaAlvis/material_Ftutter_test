import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/contact_support/filters.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_support_type.g.dart';

@JsonSerializable()
class BodySupportType {
  BodySupportType({
    required this.filters,
    required this.pagination,
  });

  factory BodySupportType.fromJson(Map<String, dynamic> json) =>
      _$BodySupportTypeFromJson(json);

  Filters filters;
  Pagination pagination;

  Map<String, dynamic> toJson() => _$BodySupportTypeToJson(this);
}
