import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_info_user_publish.g.dart';

@JsonSerializable()
class BodyInfoUserPublish{

  BodyInfoUserPublish({
    required this.id,
  });
  factory BodyInfoUserPublish.fromJson(Map<String, dynamic> json) =>
      _$BodyInfoUserPublishFromJson(json);



  String id;
  // Pagination pagination


  Map<String, dynamic> toJson() => _$BodyInfoUserPublishToJson(this);
}