import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/filters.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_home.g.dart';

@JsonSerializable()
class BodyHome {
  BodyHome({
    required this.filters,
    required this.pagination,
  });

  factory BodyHome.fromJson(Map<String, dynamic> json) =>
      _$BodyHomeFromJson(json);

  Filters filters;
  Pagination pagination;

  Map<String, dynamic> toJson() => _$BodyHomeToJson(this);
}
