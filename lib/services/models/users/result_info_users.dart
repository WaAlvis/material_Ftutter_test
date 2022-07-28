import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/users/info_users.dart';

part 'result_info_users.g.dart';

@JsonSerializable()
class ResultUsersInteractorInfo {
  ResultUsersInteractorInfo({
    this.userPublish,
    this.userOperator,
  });

  factory ResultUsersInteractorInfo.fromJson(Map<String, dynamic> json) =>
      _$ResultUsersInteractorInfoFromJson(json);

  InfoUsers? userPublish;
  InfoUsers? userOperator;

  Map<String, dynamic> toJson() => _$ResultUsersInteractorInfoToJson(this);
}
