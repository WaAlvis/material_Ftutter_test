import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/pagination.dart';

part 'body_home.g.dart';

@JsonSerializable()
class BodyHome {
  BodyHome({
    required this.type,
    required this.pagination,


      });

  factory BodyHome.fromJson(Map<String, dynamic> json) =>
      _$BodyHomeFromJson(json);

  int type;
  Pagination pagination;



  Map<String, dynamic> toJson() => _$BodyHomeToJson(this);
}
