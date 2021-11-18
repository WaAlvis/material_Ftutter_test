import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/pagination.dart';

part 'body_home.g.dart';

@JsonSerializable()
class Bodyhome {
  Bodyhome({
    required this.type,
    required this.pagination,


      });

  factory Bodyhome.fromJson(Map<String, dynamic> json) =>
      _$BodyhomeFromJson(json);

  int type;
  Pagination pagination;



  Map<String, dynamic> toJson() => _$BodyhomeToJson(this);
}
